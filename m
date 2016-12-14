From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Wed, 14 Dec 2016 00:44:22 +0000
Subject: [Intel-wired-lan] [PATCH] ethtool: stop the line wrapping
 madness
In-Reply-To: <201612140843.eOm24nKy%fengguang.wu@intel.com>
References: <20161213224106.34941-1-mitch.a.williams@intel.com>
 <201612140843.eOm24nKy%fengguang.wu@intel.com>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D804A49D0@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: lkp
> Sent: Tuesday, December 13, 2016 4:42 PM
> To: Williams, Mitch A <mitch.a.williams@intel.com>
> Cc: kbuild-all at 01.org; intel-wired-lan at lists.osuosl.org;
> netanel at annapurnalabs.com; saeed at annapurnalabs.com; zorik at annapurnalabs.com;
> decot at googlers.com
> Subject: Re: [Intel-wired-lan] [PATCH] ethtool: stop the line wrapping
> madness
> 
> Hi Mitch,
> 
> [auto build test ERROR on net-next/master]
> [cannot apply to v4.9]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Mitch-Williams/ethtool-
> stop-the-line-wrapping-madness/20161214-065626
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-
> tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c: In function
> 'nicvf_get_link_ksettings':
> >> drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c:174:2: error:
> implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
> [-Werror=implicit-function-declaration]
>      ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 

Thanks, zero-day crew. I've already sent v2 of this patch to fix this very error.

-Mitch


> vim +/ethtool_convert_legacy_u32_to_link_mode +174
> drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
> 
> bfd8d977 Philippe Reynes       2016-12-10  168  		supported |=
> SUPPORTED_40000baseCR4_Full;
> 1cc70259 Thanneeru Srinivasulu 2016-11-24  169  		break;
> 4863dea3 Sunil Goutham         2015-05-26  170  	}
> bfd8d977 Philippe Reynes       2016-12-10  171  	cmd->base.duplex = nic-
> >duplex;
> bfd8d977 Philippe Reynes       2016-12-10  172  	cmd->base.speed = nic-
> >speed;
> bfd8d977 Philippe Reynes       2016-12-10  173
> bfd8d977 Philippe Reynes       2016-12-10 @174
> 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> bfd8d977 Philippe Reynes       2016-12-10  175
> 	supported);
> bfd8d977 Philippe Reynes       2016-12-10  176
> 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
> bfd8d977 Philippe Reynes       2016-12-10  177
> 	advertising);
> 
> :::::: The code at line 174 was first introduced by commit
> :::::: bfd8d977af2390e646d4a5df8e88c1d7a1ae63d9 net: nicvf: use new api
> ethtool_{get|set}_link_ksettings
> 
> :::::: TO: Philippe Reynes <tremyfr@gmail.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
