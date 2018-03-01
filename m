From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 1 Mar 2018 15:05:44 -0800
Subject: [Intel-wired-lan] ixgbe, TSO, and NETIF_F_TSO_MANGLEID
Message-ID: <2e4fbd7e-6ecc-7811-9275-6971d745977e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi folks,

In trying to get TSO working for ipsec offload, I've found that 
NETIF_F_TSO_MANGLEID is not set, so the NETIF_F_TSO bit is getting 
stripped in ixgbe_features_check().

Back in commit
commit b83e30104bd9 ("ixgbe/ixgbevf: Add support for GSO partial")

NETIF_F_TSO_MANGLEID was added to netdev->vlan_features in 
ixgbe_probe(), but it is never added to netdev->features.  The patch 
also added a check for NETIF_F_TSO_MANGLEID in ixgbe_features_check(), 
but the test is looking in the "features" passed into the function.  As 
far as I can tell, the calls into .ndo_features_check() are using 
dev->features, not dev->vlan_features.

Should NETIF_F_TSO_MANGLEID be added to netdev->features as well? 
Something like:

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c 
b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 82c0543..dcb408b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10441,7 +10441,9 @@ static int ixgbe_probe(struct pci_dev *pdev, 
const struct pci_device_id *ent)
         if (pci_using_dac)
                 netdev->features |= NETIF_F_HIGHDMA;

-       netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
+       netdev->features |= NETIF_F_TSO_MANGLEID;
+       netdev->vlan_features |= NETIF_F_TSO_MANGLEID;
+
         netdev->hw_enc_features |= netdev->vlan_features;
         netdev->mpls_features |= NETIF_F_SG |
                                  NETIF_F_TSO |



Cheers,
sln

-- 
==================================================
Shannon Nelson           shannon.nelson at oracle.com
Parents can't afford to be squeamish
