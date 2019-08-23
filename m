From: Forrest Fleming <ffleming@gmail.com>
Date: Fri, 23 Aug 2019 19:14:21 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: Cleanup e1000 - add space
 between }}
Message-ID: <20190823191421.3318-1-ffleming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

suggested by checkpatch

Signed-off-by: Forrest Fleming <ffleming@gmail.com>
---
 .../net/ethernet/intel/e1000/e1000_param.c    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_param.c b/drivers/net/ethernet/intel/e1000/e1000_param.c
index d3f29ffe1e47..1a1f2f0237f9 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_param.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_param.c
@@ -266,7 +266,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.arg  = { .r = {
 				.min = E1000_MIN_TXD,
 				.max = mac_type < e1000_82544 ? E1000_MAX_TXD : E1000_MAX_82544_TXD
-				}}
+				} }
 		};
 
 		if (num_TxDescriptors > bd) {
@@ -295,7 +295,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 				.min = E1000_MIN_RXD,
 				.max = mac_type < e1000_82544 ? E1000_MAX_RXD :
 				       E1000_MAX_82544_RXD
-			}}
+			} }
 		};
 
 		if (num_RxDescriptors > bd) {
@@ -341,7 +341,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.err  = "reading default settings from EEPROM",
 			.def  = E1000_FC_DEFAULT,
 			.arg  = { .l = { .nr = ARRAY_SIZE(fc_list),
-					 .p = fc_list }}
+					 .p = fc_list } }
 		};
 
 		if (num_FlowControl > bd) {
@@ -359,7 +359,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.err  = "using default of " __MODULE_STRING(DEFAULT_TIDV),
 			.def  = DEFAULT_TIDV,
 			.arg  = { .r = { .min = MIN_TXDELAY,
-					 .max = MAX_TXDELAY }}
+					 .max = MAX_TXDELAY } }
 		};
 
 		if (num_TxIntDelay > bd) {
@@ -377,7 +377,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.err  = "using default of " __MODULE_STRING(DEFAULT_TADV),
 			.def  = DEFAULT_TADV,
 			.arg  = { .r = { .min = MIN_TXABSDELAY,
-					 .max = MAX_TXABSDELAY }}
+					 .max = MAX_TXABSDELAY } }
 		};
 
 		if (num_TxAbsIntDelay > bd) {
@@ -395,7 +395,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.err  = "using default of " __MODULE_STRING(DEFAULT_RDTR),
 			.def  = DEFAULT_RDTR,
 			.arg  = { .r = { .min = MIN_RXDELAY,
-					 .max = MAX_RXDELAY }}
+					 .max = MAX_RXDELAY } }
 		};
 
 		if (num_RxIntDelay > bd) {
@@ -413,7 +413,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.err  = "using default of " __MODULE_STRING(DEFAULT_RADV),
 			.def  = DEFAULT_RADV,
 			.arg  = { .r = { .min = MIN_RXABSDELAY,
-					 .max = MAX_RXABSDELAY }}
+					 .max = MAX_RXABSDELAY } }
 		};
 
 		if (num_RxAbsIntDelay > bd) {
@@ -431,7 +431,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.err  = "using default of " __MODULE_STRING(DEFAULT_ITR),
 			.def  = DEFAULT_ITR,
 			.arg  = { .r = { .min = MIN_ITR,
-					 .max = MAX_ITR }}
+					 .max = MAX_ITR } }
 		};
 
 		if (num_InterruptThrottleRate > bd) {
@@ -545,7 +545,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 			{          0, "" },
 			{   SPEED_10, "" },
 			{  SPEED_100, "" },
-			{ SPEED_1000, "" }};
+			{ SPEED_1000, "" } };
 
 		opt = (struct e1000_option) {
 			.type = list_option,
@@ -553,7 +553,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 			.err  = "parameter ignored",
 			.def  = 0,
 			.arg  = { .l = { .nr = ARRAY_SIZE(speed_list),
-					 .p = speed_list }}
+					 .p = speed_list } }
 		};
 
 		if (num_Speed > bd) {
@@ -567,7 +567,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 		static const struct e1000_opt_list dplx_list[] = {
 			{           0, "" },
 			{ HALF_DUPLEX, "" },
-			{ FULL_DUPLEX, "" }};
+			{ FULL_DUPLEX, "" } };
 
 		opt = (struct e1000_option) {
 			.type = list_option,
@@ -575,7 +575,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 			.err  = "parameter ignored",
 			.def  = 0,
 			.arg  = { .l = { .nr = ARRAY_SIZE(dplx_list),
-					 .p = dplx_list }}
+					 .p = dplx_list } }
 		};
 
 		if (num_Duplex > bd) {
@@ -623,7 +623,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 			 { 0x2c, AA "1000/FD, 100/FD, 100/HD" },
 			 { 0x2d, AA "1000/FD, 100/FD, 100/HD, 10/HD" },
 			 { 0x2e, AA "1000/FD, 100/FD, 100/HD, 10/FD" },
-			 { 0x2f, AA "1000/FD, 100/FD, 100/HD, 10/FD, 10/HD" }};
+			 { 0x2f, AA "1000/FD, 100/FD, 100/HD, 10/FD, 10/HD" } };
 
 		opt = (struct e1000_option) {
 			.type = list_option,
@@ -631,7 +631,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 			.err  = "parameter ignored",
 			.def  = AUTONEG_ADV_DEFAULT,
 			.arg  = { .l = { .nr = ARRAY_SIZE(an_list),
-					 .p = an_list }}
+					 .p = an_list } }
 		};
 
 		if (num_AutoNeg > bd) {
-- 
2.17.1

