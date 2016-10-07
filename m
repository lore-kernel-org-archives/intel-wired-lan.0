From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 19:28:39 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 05/15] i40e: When
 searching	all MAC/VLAN filters, ignore removed filters
In-Reply-To: <1475685046-16900-6-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC82@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 05/15] i40e: When searching all
> MAC/VLAN filters, ignore removed filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When adding new MAC address filters, the driver determines if it should
> behave in VLAN mode (where all MAC addresses get assigned to every
> existing VLAN) or in non-VLAN mode where MAC addresses get assigned the
> VLAN_ANY identifier. Under some circumstances it is possible that a VLAN
> has been marked for removal (such that all filters of that VLAN are set to
> I40E_FILTER_REMOVE), and a subsequent call to i40e_put_mac_in_vlan may
> occur prior to the driver subtask that syncs filters to the hardware.
> 
> In this case, we may add filters to the new removed VLAN, even though it
> should have been removed. This is most obvious when first adding a new
> VLAN. We will delete all filters which are in I40E_VLAN_ANY (-1) and then re-
> add them as in VLAN 0 (untagged). Then before we sync filters, we will add
> new MAC address filter, which will be added to every VLAN that exists.
> Unfortunately, this will include I40E_VLAN_ANY, so we will end up incorrectly
> adding filters to the -1 VLAN. This can be fixed by simply skipping all filters
> which are marked for removal.
> 
> A similar check is not necessary in i40e_del_mac_all_vlan, since we are
> deleting, and any filter which we find already marked for removal would
> simply be deleted again, which doesn't cause any issues.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: I7962154013ce02fe950584690aeeb3ed853d0086
> ---
> Testing-hints:
>   1. Load driver and bring link up
>     modprobe i40e
>     ip link set enp130s0 up
>   2. Add a VLAN
>     ip link add link enp130s0 enp130s0.4000 type vlan id 4000
>     ip link set enp130s0.4000 up
>   3. Dump filters:
>     echo "dump filters" > /sys/kernel/debug/i40e/0000:82:00.0/command
>     dmesg | tail -n40
> 
>   Note that without this patch you should see some filters repeated with
>   both VLAN 0 and VLAN -1, when we expect only seeing filters on VLAN 0.
>   It may take multiple steps to reproduce as it might be a race
>   condition, though I did not have trouble reproducing the issue.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Works as described
