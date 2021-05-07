From: Alex Sergeev <asergeev@carbonrobotics.com>
Date: Thu, 6 May 2021 23:14:48 -0700
Subject: [Intel-wired-lan] X710-T4L: 5Gb support for IEEE1588
Message-ID: <CAAE-T7+Q__0ONDwzm89uufc6WKrmiCsUPvW_ARhVzaRwv93JFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I got forwarded here by folks at e1000-devel at .

We have tried to use PTP with X710-T4L and 5Gb link, and encountered
clockcheck problem in phc2sys:

Apr 30 22:57:36 budtb phc2sys[5940]: [50.569] clockcheck: clock jumped
forward or running faster than expected!

After further code examination, it turned out that 5Gb case is not handled
in i40e_ptp.c

Here's the naive version of the patch that fixed the problem for us:

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f1f6fc3744e9..5747b652ee9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -12,12 +12,13 @@
  *
  * Much like the 82599, the update period is dependent upon the link speed:
  * At 40Gb link or no link, the period is 1.6ns.
- * At 10Gb link, the period is multiplied by 2. (3.2ns)
+ * At 5Gb or 10Gb link, the period is multiplied by 2. (3.2ns)
  * At 1Gb link, the period is multiplied by 20. (32ns)
  * 1588 functionality is not supported at 100Mbps.
  */
 #define I40E_PTP_40GB_INCVAL 0x0199999999ULL
 #define I40E_PTP_10GB_INCVAL_MULT 2
+#define I40E_PTP_5GB_INCVAL_MULT    2
 #define I40E_PTP_1GB_INCVAL_MULT 20

 #define I40E_PRTTSYN_CTL1_TSYNTYPE_V1
 BIT(I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
@@ -465,6 +466,9 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
  case I40E_LINK_SPEED_10GB:
      mult = I40E_PTP_10GB_INCVAL_MULT;
      break;
+ case I40E_LINK_SPEED_5GB:
+     mult = I40E_PTP_5GB_INCVAL_MULT;
+     break;
  case I40E_LINK_SPEED_1GB:
      mult = I40E_PTP_1GB_INCVAL_MULT;
      break;

What's the process to get it applied upstream?

Thanks,
Alex Sergeev
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210506/0ff8de27/attachment.html>
-------------- next part --------------
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f1f6fc3744e9..5747b652ee9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -12,12 +12,13 @@
  *
  * Much like the 82599, the update period is dependent upon the link speed:
  * At 40Gb link or no link, the period is 1.6ns.
- * At 10Gb link, the period is multiplied by 2. (3.2ns)
+ * At 5Gb or 10Gb link, the period is multiplied by 2. (3.2ns)
  * At 1Gb link, the period is multiplied by 20. (32ns)
  * 1588 functionality is not supported at 100Mbps.
  */
 #define I40E_PTP_40GB_INCVAL		0x0199999999ULL
 #define I40E_PTP_10GB_INCVAL_MULT	2
+#define I40E_PTP_5GB_INCVAL_MULT    2
 #define I40E_PTP_1GB_INCVAL_MULT	20
 
 #define I40E_PRTTSYN_CTL1_TSYNTYPE_V1  BIT(I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
@@ -465,6 +466,9 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
 	case I40E_LINK_SPEED_10GB:
 		mult = I40E_PTP_10GB_INCVAL_MULT;
 		break;
+	case I40E_LINK_SPEED_5GB:
+		mult = I40E_PTP_5GB_INCVAL_MULT;
+		break;
 	case I40E_LINK_SPEED_1GB:
 		mult = I40E_PTP_1GB_INCVAL_MULT;
 		break;
