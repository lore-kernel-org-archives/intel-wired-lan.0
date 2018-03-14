From: Timur Tabi <timur@codeaurora.org>
Date: Wed, 14 Mar 2018 00:08:51 -0500
Subject: [Intel-wired-lan] [PATCH 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
Message-ID: <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/13/18 10:20 PM, Sinan Kaya wrote:
> +/* Assumes caller has executed a write barrier to order memory and device
> + * requests.
> + */
>   static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32 value)
>   {
> -	writel(value, ring->tail);
> +	writel_relaxed(value, ring->tail);
>   }

Why not put the wmb() in this function, or just get rid of the wmb() in 
the rest of the file and keep this as writel?  That way, you can avoid 
the comment and the risk that comes with it.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
