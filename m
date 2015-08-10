From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 11 Aug 2015 00:45:31 +0300
Subject: [Intel-wired-lan] i40e/i40evf: RSS changes for X722
Message-ID: <20150810214531.GD31724@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Anjali Singhai Jain,

The patch e25d00b87b26: "i40e/i40evf: RSS changes for X722" from Jun
23, 2015, leads to the following static checker warning:

	drivers/net/ethernet/intel/i40e/i40e_main.c:7516 i40e_config_rss_aq()
	warn: possible memory leak of 'rss_lut'

drivers/net/ethernet/intel/i40e/i40e_main.c
  7501  
  7502          rss_lut = kzalloc(pf->rss_table_size, GFP_KERNEL);
  7503          if (!rss_lut)
  7504                  return -ENOMEM;
  7505  
  7506          /* Populate the LUT with max no. of queues in round robin fashion */
  7507          for (i = 0; i < vsi->rss_table_size; i++)
  7508                  rss_lut[i] = i % vsi->rss_size;
  7509  
  7510          ret = i40e_aq_set_rss_key(hw, vsi->id, &rss_key);
  7511          if (ret) {
  7512                  dev_info(&pf->pdev->dev,
  7513                           "Cannot set RSS key, err %s aq_err %s\n",
  7514                           i40e_stat_str(&pf->hw, ret),
  7515                           i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));

Missing kfree() here.

  7516                  return ret;
  7517          }
  7518  
  7519          if (vsi->type == I40E_VSI_MAIN)
  7520                  pf_lut = true;
  7521  
  7522          ret = i40e_aq_set_rss_lut(hw, vsi->id, pf_lut, rss_lut,
  7523                                    vsi->rss_table_size);
  7524          if (ret)
  7525                  dev_info(&pf->pdev->dev,
  7526                           "Cannot set RSS lut, err %s aq_err %s\n",
  7527                           i40e_stat_str(&pf->hw, ret),
  7528                           i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
  7529  
  7530          return ret;
  7531  }

regards,
dan carpenter
