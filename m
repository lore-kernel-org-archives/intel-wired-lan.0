From: =?unknown-8bit?q?Gr=C3=B6nke?=, Christian <C.Groenke@infodas.de>
Date: Fri, 22 Jun 2018 10:05:00 +0000
Subject: [Intel-wired-lan] igb: Problems with early PHY reset when using an
 SFP module with SGMII as phy->addr is unset
Message-ID: <98c8af132eae46318a4f3dee1d0306b6@infodas.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Aaron, Hello Jeff,

I have problems with the newer versions of the e1000 (igb) driver of current kernels. I stumbled over this with a vendor kernel[*] after they pulled in some updates. When starting on my board, which has several i210 MACs connected to SFP ports. In case I use the hardware flashed for SGMII and SGMII capable SFP modules I see errors like this:

> [ 4776.137522] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [ 4776.137525] igb: Copyright (c) 2007-2014 Intel Corporation.
[...]
> [ 4776.337079] igb: probe of 0000:09:00.0 failed with error -3

I tracked this down to the failing reset that was introduced by Aaron[*]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/intel/igb/e1000_82575.c?id=182785335447957409282ca745aa5bc3968facee
> igb: reset the PHY before reading the PHY ID

The problem here, at least for me, is that during this time in the initialization the phy->addr is '0' and thus 'e1000_write_phy_reg_sgmii_82575' fails. The SGMII PHY will only be discovered later on in 'igb_get_phy_id_82575'.

> [ 4776.336987] igb: IGB: Soft resetting SGMII attached PHY...
> [ 4776.336999] IGB: PHY I2C Address 0 is out of range.
> [ 4776.337009] igb: IGB: Error resetting the PHY.

When hacking the driver and presenting the PHY to the correct address, or doing a discovery of the PHY in case SGMII is active and MDIO is not used, it works. However, it seems a bit opposed to your patch. I understand your patch note in the way that in some cases the PHY has to be reset as otherwise the PHY ID can not be discovered and the "scan" would thus fail. May this inly be the case if SGMII is not used and thus 'igb_phy_hw_reset' would normally be called? It seems that in case SGMII is used the phy->addr has to be known to do a reset.

I know too little about all the possible IGB/i210 configuration to judge what is okay here. This is why I wanted to get in touch. I am not sure what would be the right fix. While I can fix it for myself and our product by disabling your patch and have no reset, I would much prefer an upstream fix that I can backport.

Kind regards
Christian

[*] Note: This is still the case in the most current driver on the master branch.
[*] Note2: I first observed this on a L4Linux 4.9 (https://l4linux.org/) running on L4RE. However, I can also reproduce this with a current CentOS 7.5 which has a 3.10++ kernel and a Ubuntu 18.04.

-- 

Christian GR?NKE

INFODAS GmbH ~ Rhonestra?e 2 ~ 50765 K?ln ~ Germany
Phone: +49 221 7091255 ~ Mail: c.groenke at infodas.de

