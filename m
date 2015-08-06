From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Thu, 6 Aug 2015 17:16:31 +0000
Subject: [Intel-wired-lan] [PATCH] igbvf: clear buffer_info->dma
	after	dma_unmap_single()
In-Reply-To: <1438846337-6164-1-git-send-email-sassmann@kpanic.de>
References: <1438846337-6164-1-git-send-email-sassmann@kpanic.de>
Message-ID: <253CF818969A9240AB2054BF91F2C2BC3017DE59@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 6 Aug 2015 09:32:17 +0200
Stefan Assmann <sassmann@kpanic.de> wrote:

> The driver doesn't clear buffer_info->dma after calling
> dma_unmap_single() in all cases. This has been discovered by changing
> the mtu twice, which caused the following backtrace.

should be for NET?

Looks good, thanks Stefan!

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
