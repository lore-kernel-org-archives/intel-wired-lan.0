From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Aug 2016 17:55:19 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add spinlocks for MTU
	change	calls
In-Reply-To: <20160829233928.10108.99079.stgit@localhost6.localdomain6>
References: <20160829233928.10108.99079.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FB0DE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Monday, August 29, 2016 4:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: add spinlocks for MTU change
> calls
> 
> Protect set_rlpml with mailbox lock to make sure tha MTU configuration is
> handled properly.
> 
> This change resolves an issue where set_rlpml can fail when the VF interface
> is brought up:
> ixgbevf 0000:03:1d.6: Failed to set MTU at 1500
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


