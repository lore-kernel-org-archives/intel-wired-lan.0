From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 22:38:49 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset on
 network interruption
In-Reply-To: <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
 <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
Message-ID: <1460673529.28210.11.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-04-12 at 23:22 -0400, Brian Walsh wrote:
> Time is resetting on any interruption of network connectivity. This
> causes the clock to jump around by the leapsecond offset. It should
> only reset when the device is initialized.
> 
> Signed-off-by: Brian Walsh <brian@walsh.ws>

Are you sure this is occuring when link is lost? or only when the
device resets?

Ie: what happens if all you do is remove the cable?

I suspect this is only occuring when the device is reset (such as ifup
or ifdown) which it must do, because otherwise the SYSTIME register is
just reset by the actual hardware reset.

If it's also occuring due to link change, we need to isolate and
prevent that from happening, which should resolve your issue without
breaking ifup / ifdown and io suspend and resume.

Thanks,
Jake
