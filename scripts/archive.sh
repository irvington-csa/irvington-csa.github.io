#!/bin/bash
#
# URL: https://kevincox.ca/2022/12/21/wget-mirror/
# Kevin Cox / 2022 / 12 / 21 / Mirroring a Website with Wget
# Mirroring a Website with Wget
# 
# Posted on 2022-12-21
# 
# Occasionally I want to archive a site. Maybe it is something important, or maybe the site is going offline. I often struggle to concoct the right Wget command, so I’ve recorded it here for future reference.
# 
# wget
# 	--adjust-extension \
# 	--convert-links \
# 	--mirror \
# 	--no-parent \
# 	--page-requisites \
# 	--restrict-file-names=windows \
# 	--trust-server-names \
# 	"https://example.com/tutorials"
# 
# That is the base command. You may also want --span-hosts if you want to include all third-party dependencies or --domains=cdn.example.com if you want to include assets from some domains.
# Flag Descriptions
# --adjust-extension
# 
# This ensures that some file types end with a common extension. For example HTML with .html CSS with .css and similar. This unfortunately doesn’t adjust all downloaded files but provides some improvement. Using common extensions helps when serving content from general-purpose webservers that will set the Content-Type header based on the extension.
# --convert-links
# 
# Updates links in the content to relative links. For example if the page contains <a href=https://example.com/foo> will be converted to <a href=foo> so that it works as expected when browsing the archive. It will also convert links that haven’t been archived to be absolute so that they continue working.
# --mirror
# 
# This turns on a handful of options that are recommended for mirroring. See the man page for details.
# --no-parent
# 
# Prevent archiving of top-level pages that are “above” the root URL. For example if archiving https://example.com/music links to https://other.example will not be followed and links to /work will not be followed. Note that this doesn’t prevent archiving of page requisites. So if https://example.com/music/player loads /js/music-player.js that file will still be downloaded even though it is above the root.
# --page-requisites
# 
# Download files needed to display a page. For example images, JavaScript and CSS. Note that Wget doesn’t execute JavaScript so dynamically loaded resources won’t be found.
# --restrict-file-names
# 
# By default, Wget will save files to whatever the URL path is. This doesn’t play well with all web servers. Besides filename restrictions many strip a query string such as ?v=123 before requesting the file. This means that if Wget saves example.css?v=123 it will be effectively unreachable.
# 
# I use windows because it is built in and seems to cover the most important cases.
# --trust-server-names
# 
# This flag changes how Wget names files when it encounters a redirect. By default, it saves based on the initial URL, this makes it save based on the final URL. This is useful because of how Wget deals with multiple URLs that end up at the same URL after resolving any redirects. By default, it will pick a random initial URL and rewrite all links to that, this can result in weird URLs appearing. For example WordPress sites have links to /index.html?p=985 which redirect to the regular post URL. Often Wget will end up selecting one of these and rewriting all of the links to point at it which is unsightly.
# Other Options
# 
# I’m not aware of any other easy options for full-site archiving. One interesting approach would be using something like AssetGraph to fetch the site. It has a much more powerful analysis engine (including parsing scripts) that would catch more dynamic URL references as well as a scriptable AST-like reference that would allow for better cleanup of the site (for example merging URLs with different parameters but identical content).
# Feed - Newsletter - Private Feedback
# 
# 
DATE=$(date --iso-8601=date)
DIR="archive/$DATE"
if [ ! -d "$DIR" ]
then
  mkdir $DIR
fi
wget \
  --adjust-extension \
  --convert-links \
  --mirror \
  --no-parent \
  --page-requisites \
  --restrict-file-names=windows \
  --trust-server-names \
  --directory-prefix=$DIR \
  "https://irvingtoncsa.org/"
