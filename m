From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 30 Sep 2016 13:41:01 +0300
Subject: [Intel-wired-lan] [bug report] i40e: Fix kernel panic on
	enable/disable LLDP
Message-ID: <20160930104101.GA10918@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Dave Ertman,

The patch a036244c0686: "i40e: Fix kernel panic on enable/disable
LLDP" from Aug 29, 2016, leads to the following static checker
warning:

	drivers/net/ethernet/intel/i40e/i40e_main.c:10958 i40e_probe()
	warn: odd binop '0x20000000 & 0x100000'

drivers/net/ethernet/intel/i40e/i40e_main.c
 10952          pci_set_drvdata(pdev, pf);
 10953          pci_save_state(pdev);
 10954  #ifdef CONFIG_I40E_DCB
 10955          err = i40e_init_pf_dcb(pf);
 10956          if (err) {
 10957                  dev_info(&pdev->dev, "DCB init failed %d, disabled\n", err);
 10958                  pf->flags &= ~(I40E_FLAG_DCB_CAPABLE & I40E_FLAG_DCB_ENABLED);

Should this be an | instead of an &?  The current code is a no-op.

 10959                  /* Continue without DCB enabled */
 10960          }
 10961  #endif /* CONFIG_I40E_DCB */

regards,
dan carpenter
