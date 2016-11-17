From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 18:11:15 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 11/15] i40e:
	restore	workaround for removing default MAC filter
In-Reply-To: <1478639119-14656-12-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37F23@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S52-V2 11/15] i40e: restore
> workaround for removing default MAC filter
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A previous commit 53cb6e9e8949 ("i40e: Removal of workaround for simple
> MAC address filter deletion") removed a workaround for some firmware
> versions which was reported to not be necessary in production NICs.
> Unfortunately this workaround is necessary in some configurations,
> specifically the Ethernet Controller XL710 for 40GbE QSFP+ (8086:1583).
> 
> Without this patch, the mentioned NICs with current firmware exhibit issues
> when adding VLANs, as outlined by the following reproduction:
> 
>   $modprobe i40e
>   $ip link set <device> up
>   $ip link add link <device> vlan100 type vlan id 100
>   $dmesg | tail
>   <snip>
>   kernel: i40e 0000:82:00.0: Error I40E_AQ_RC_EINVAL adding RX filters on PF,
> promiscuous mode forced on
> 
> This results in filters being marked as FAILED and setting the device in
> promiscuous mode.
> 
> The root cause of receiving the -EINVAL error response appears to be due to
> a conflict with the default MAC filter which still exists on the default firmware
> for this device. Attempting to add a new VLAN filter on the default MAC
> address conflicts with the IGNORE_VLAN setting on the default rule.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I4d8f6d48ac5f60cfe981b3baad30eb4d7c170d61
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 41
> +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Adding VLAN with device 1583 successful, no error message recorded


