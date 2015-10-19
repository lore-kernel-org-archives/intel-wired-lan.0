From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Mon, 19 Oct 2015 16:56:15 +0000
Subject: [Intel-wired-lan] [PATCH] intel: i40e: fix confused code
In-Reply-To: <1445115499-28728-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1445115499-28728-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AFA4A68@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Rasmus Villemoes [mailto:linux at rasmusvillemoes.dk]
> Sent: Saturday, October 17, 2015 1:58 PM
> Subject: [PATCH] intel: i40e: fix confused code
> 
> This code is pretty confused. The variable name 'bytes_not_copied'
> clearly indicates that the programmer knew the semantics of
> copy_{to,from}_user, but then the return value is checked for being
> negative and used as a -Exxx return value.
> 
> I'm not sure this is the proper fix, but at least we get rid of the
> dead code which pretended to check for access faults.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I believe this patch is unnecessary: if the value is negative, then it already is an error code giving some potentially useful information.  When I dig into the copy_to_user() code, I see in the comments for put_user() that -EFAULT is the error being returned.  Also, if somewhere else along the line there is some other error, I'd prefer to return that value rather than stomp on it with my own error code.  

sln

