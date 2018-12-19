From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Dec 2018 19:56:19 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] xsk: export xdp_get_umem_from_qid
In-Reply-To: <20181218134514.6388-1-jan.sokolowski@intel.com>
References: <20181218134514.6388-1-jan.sokolowski@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343816@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jan Sokolowski
> Sent: Tuesday, December 18, 2018 5:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] xsk: export xdp_get_umem_from_qid
> 
> Export xdp_get_umem_from_qid for other modules to use.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  net/xdp/xdp_umem.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


