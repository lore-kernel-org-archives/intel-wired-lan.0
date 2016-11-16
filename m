From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 18:56:04 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 01/15] i40evf: check
	for	msix_entries null dereference
In-Reply-To: <1478639119-14656-2-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA35CF9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S52-V2 01/15] i40evf: check for
> msix_entries null dereference
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> It is possible for msix_entries to be freed by a previous suspend/remove
> before a VF is closed.  This patch fixes the issue by checking for NULL before
> dereferencing msix_entries and returning early in the case where it is NULL
> within the i40evf_close code path.  Without this patch it is possible to trigger
> a kernel panic through NULL dereference.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: I92a2746e82533a889e25f91578eac9abd0388ae2
> ---
> Testing-hints:
>     Create lots of VFs and bring themm up on the host, assign them and the PF
> to namespaces, then shut the system down.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Was able to shut system down with many VFs assigned to namespaces, no kernel panic


