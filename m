From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 14 Sep 2020 16:24:18 -0700
Subject: [Intel-wired-lan] [PATCH][next][v2] iavf: use kvzalloc instead
 of kzalloc for rx/tx_bi buffer
In-Reply-To: <1598592392-30673-1-git-send-email-lirongqing@baidu.com>
References: <1598592392-30673-1-git-send-email-lirongqing@baidu.com>
Message-ID: <20200914162418.00007393@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Li RongQing wrote:

> when changes the rx/tx ring to 4096, kzalloc may fail due to
> a temporary shortage on slab entries.
> 
> so using kvmalloc to allocate this memory as there is no need
> that this memory area is physical continuously.
> 
> and using __GFP_RETRY_MAYFAIL to allocate from kmalloc as
> far as possible, which can reduce TLB pressure than vmalloc
> as suggested by Eric Dumazet

This change is no good, it's using RETRY_MAYFAIL but still using
v*alloc.

Please see my replies to the i40e version of the patch. I don't think
we should apply these.
