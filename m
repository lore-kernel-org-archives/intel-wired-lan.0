From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 11 Nov 2021 16:37:48 +0300
Subject: [Intel-wired-lan] [bug report] ice: Add support to print error on
 PHY FW load failure
Message-ID: <20211111133748.GA22374@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Brett Creeley,

The patch 99d407524cdf: "ice: Add support to print error on PHY FW
load failure" from Oct 13, 2021, leads to the following Smatch static
checker warning:

	drivers/net/ethernet/intel/ice/ice_main.c:956 ice_check_phy_fw_load()
	warn: duplicate check 'link_cfg_err & ((((1))) << (6))' (previous on line 948)

drivers/net/ethernet/intel/ice/ice_main.c
    946 static void ice_check_phy_fw_load(struct ice_pf *pf, u8 link_cfg_err)
    947 {
    948         if (!(link_cfg_err & ICE_AQ_LINK_EXTERNAL_PHY_LOAD_FAILURE)) {
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
There is a check here.

    949                 clear_bit(ICE_FLAG_PHY_FW_LOAD_FAILED, pf->flags);
    950                 return;
    951         }
    952 
    953         if (test_bit(ICE_FLAG_PHY_FW_LOAD_FAILED, pf->flags))
    954                 return;
    955 
--> 956         if (link_cfg_err & ICE_AQ_LINK_EXTERNAL_PHY_LOAD_FAILURE) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We already know this condition is true.


    957                 dev_err(ice_pf_to_dev(pf), "Device failed to load the FW for the external PHY. Please download and install the latest NVM for your device and try again\n");
    958                 set_bit(ICE_FLAG_PHY_FW_LOAD_FAILED, pf->flags);
    959         }
    960 }

regards,
dan carpenter
