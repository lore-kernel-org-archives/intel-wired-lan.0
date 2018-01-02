From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 2 Jan 2018 11:56:00 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Delete an error message for a
 failed memory allocation in i40e_init_interrupt_scheme()
In-Reply-To: <c9c151e5-bd26-5b72-d26b-c153249811ab@users.sourceforge.net>
References: <c9c151e5-bd26-5b72-d26b-c153249811ab@users.sourceforge.net>
Message-ID: <20180102115600.000047c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 1 Jan 2018 20:43:35 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 1 Jan 2018 20:38:14 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for the patch.

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
