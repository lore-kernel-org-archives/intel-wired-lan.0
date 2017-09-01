From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 01 Sep 2017 14:34:17 -0700
Subject: [Intel-wired-lan] [PATCH 31/31] timer: Switch to testing for
 .function instead of .data
In-Reply-To: <1504222183-61202-32-git-send-email-keescook@chromium.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-32-git-send-email-keescook@chromium.org>
Message-ID: <1504301657.3922.47.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-08-31 at 16:29 -0700, Kees Cook wrote:
> In several places, .data is checked for initialization to gate early
> calls to del_timer_sync(). Checking for .function is equally valid,
> so
> switch to this in all callers.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Sean Hefty <sean.hefty@intel.com>
> Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: linux-pm at vger.kernel.org
> Cc: linux-rdma at vger.kernel.org
> Cc: linux-input at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

For the changes to i40e...

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170901/8caea8f2/attachment.asc>
