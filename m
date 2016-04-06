From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 6 Apr 2016 21:37:03 +0300
Subject: [Intel-wired-lan] fm10k: use ethtool_rxfh_indir_default for
 default redirection table
Message-ID: <20160406183703.GA27407@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Jacob Keller,

The patch 0ea7fae44094: "fm10k: use ethtool_rxfh_indir_default for
default redirection table" from Feb 16, 2016, leads to the following
static checker warning:

	drivers/net/ethernet/intel/fm10k/fm10k_main.c:1977 fm10k_init_reta()
	error: potential null dereference 'indir'.  (kcalloc returns null)

drivers/net/ethernet/intel/fm10k/fm10k_main.c
  1970  
  1971  repopulate_reta:
  1972          indir = kcalloc(fm10k_get_reta_size(netdev),
  1973                          sizeof(indir[0]), GFP_KERNEL);
  1974  
  1975          /* generate redirection table using the default kernel policy */
  1976          for (i = 0; i < fm10k_get_reta_size(netdev); i++)
  1977                  indir[i] = ethtool_rxfh_indir_default(i, rss_i);
  1978  
  1979          fm10k_write_reta(interface, indir);
  1980  
  1981          kfree(indir);
  1982  }


regards,
dan carpenter
