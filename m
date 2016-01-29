From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 29 Jan 2016 18:24:19 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe:
	use	eth_platform_get_mac_address()
In-Reply-To: <1328c02108145ebd083cc6f1480dc90147f068f0.1452655483.git.sowmini.varadhan@oracle.com>
References: <cover.1452655483.git.sowmini.varadhan@oracle.com>
 <1328c02108145ebd083cc6f1480dc90147f068f0.1452655483.git.sowmini.varadhan@oracle.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D2962F@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sowmini Varadhan
> Sent: Tuesday, January 12, 2016 7:32 PM
> To: Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn;
> Skidmore, Donald C; Allan, Bruce W; Ronciak, John; Williams, Mitch A; intel-
> wired-lan at lists.osuosl.org
> Cc: sowmini.varadhan at oracle.com; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: use
> eth_platform_get_mac_address()
> 
> This commit converts commit c762dff24c06 ("ixgbe: Look up MAC address in
> Open Firmware or IDPROM") to use eth_platform_get_mac_address() added by
> commit c7f5d105495a ("net: Add eth_platform_get_mac_address()
> helper.")
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

I don't have any SPARC systems to test this on.
I've tested to check that this patch doesn't seem to break anything on X86_64 systems.
Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>



