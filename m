From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 30 Dec 2018 16:53:07 +0100
Subject: [Intel-wired-lan] [PATCH 0/8] reduce indentation
Message-ID: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These patches fix cases where a subsequent statement is aligned
with the right hand side of an assignment rather than the left
hand side.  This was done using the following semantic match
(http://coccinelle.lip6.fr/).  It has a lot of false positives,
because Coccinelle doesn't record the difference between a space
and a tab, but these issues are easy to skip over.

// <smpl>
@r@
expression x,e;
statement S;
position p0,p1,p2;
@@
x at p0 = e at p1;
S at p2

@script:ocaml@
p0 << r.p0;
p1 << r.p1;
p2 << r.p2;
@@
if ((List.hd p0).col < (List.hd p1).col &&
    (List.hd p1).col = (List.hd p2).col)
then Coccilib.print_main "" p1
// </smpl>

---

 drivers/firmware/stratix10-svc.c              |   12 ++++++------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |    2 +-
 drivers/iommu/msm_iommu.c                     |    8 ++++----
 drivers/net/ethernet/amazon/ena/ena_eth_com.c |    4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |    2 +-
 drivers/scsi/pm8001/pm8001_sas.c              |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |    6 +++---
 drivers/usb/gadget/udc/snps_udc_core.c        |   17 ++++++++---------
 8 files changed, 26 insertions(+), 27 deletions(-)
