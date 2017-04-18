From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 18 Apr 2017 17:48:06 +0200
Subject: [Intel-wired-lan] Outdated URLs in `e1000e.txt`
Message-ID: <0a74fa60-8cc2-4215-5dfe-150fcf8245f5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear e1000e Linux folks,


the document `./Documentation/networking/e1000e.txt` [1] contains two 
URLs, which, I believe, are outdated.

1.  http://support.intel.com/support/go/network/adapter/idguide.htm
2.  http://support.intel.com/support/go/network/adapter/home.htm

Both redirect to a generic support site [2] (not HTTPS by default).

```
$ curl -I http://support.intel.com/support/go/network/adapter/idguide.htm
HTTP/1.0 301 Moved Permanently
Location: 
http://corpredirect.intel.com/Redirector/404Redirector.aspx?http://support.intel.com/support/go/network/adapter/idguide.htm
Server: BigIP
Connection: close
Content-Length: 0

```

Could these please be updated, or removed?


Kind regards,

Paul


[1] https://www.kernel.org/doc/Documentation/networking/e1000e.txt
[2] https://www.intel.com/content/www/us/en/support.html
