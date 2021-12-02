From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 2 Dec 2021 07:41:34 +0100
Subject: [Intel-wired-lan] [PATCH] igc: Avoid possible deadlock during
 suspend/resume
In-Reply-To: <20211201185731.236130-1-vinicius.gomes@intel.com>
References: <87r1awtdx3.fsf@intel.com>
 <20211201185731.236130-1-vinicius.gomes@intel.com>
Message-ID: <YahqnvgmT63iG48E@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 01, 2021 at 10:57:31AM -0800, Vinicius Costa Gomes wrote:
> Inspired by:
> https://bugzilla.kernel.org/show_bug.cgi?id=215129
> 

This changelog does not say anything at all, sorry.  Please explain what
is happening here as the kernel documentation asks you to.

> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> Just to see if it's indeed the same problem as the bug report above.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
