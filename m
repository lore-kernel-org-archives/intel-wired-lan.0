From: Vinod Koul <vkoul@kernel.org>
Date: Tue, 27 Nov 2018 19:28:09 +0530
Subject: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181127135809.GB3175@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26-11-18, 17:56, Anshuman Khandual wrote:
> At present there are multiple places where invalid node number is encoded
> as -1. Even though implicitly understood it is always better to have macros
> in there. Replace these open encodings for an invalid node number with the
> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
> 'invalid node' from various places redirecting them to a common definition.
> 

>  drivers/dma/dmaengine.c                       |  4 +++-


Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
