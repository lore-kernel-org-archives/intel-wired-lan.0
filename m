From: kbuild test robot <lkp@intel.com>
Date: Sat, 8 Feb 2020 01:58:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 75/75]
 drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202002080142.jXgA7Lza%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   efd2087941d2bc08b6c0a559aab0d8cdcfa38e0f
commit: efd2087941d2bc08b6c0a559aab0d8cdcfa38e0f [75/75] gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-159-g100509c0-dirty
        git checkout efd2087941d2bc08b6c0a559aab0d8cdcfa38e0f
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse: sparse: incorrect type in initializer (different address spaces)
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse:    expected void [noderef] <asn:2> *base
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse:    got void *context
   drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:41:30: sparse: sparse: incorrect type in initializer (different address spaces)
   drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:41:30: sparse:    expected void [noderef] <asn:2> *base
   drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:41:30: sparse:    got void *context
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:77:30: sparse: sparse: incorrect type in argument 3 (different address spaces)
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:77:30: sparse:    expected void *bus_context
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:77:30: sparse:    got void [noderef] <asn:2> *[assigned] core
--
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:38:5: sparse: sparse: symbol 'mac_get_speed' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:50:5: sparse: sparse: symbol 'mac_set_physpeed' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:119:5: sparse: sparse: symbol 'mac_set_duplex' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:144:5: sparse: sparse: symbol 'mac_get_duplex' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:156:5: sparse: sparse: symbol 'mac_get_linksts' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:168:5: sparse: sparse: symbol 'mac_set_linksts' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:193:5: sparse: sparse: symbol 'mac_set_flowctrl' was not declared. Should it be static?
--
>> drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c:478:5: sparse: sparse: symbol 'xgmac_mdio_single_wr' was not declared. Should it be static?
>> drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c:529:5: sparse: sparse: symbol 'xgmac_mdio_single_rd' was not declared. Should it be static?

Please review and possibly fold the followup patch.

vim +32 drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c

    29	
    30	static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
    31	{
  > 32		void __iomem *base = context;
    33	
    34		writew(val, base + reg);
    35	
    36		return 0;
    37	}
    38	
    39	static int regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
    40	{
    41		void __iomem *base = context;
    42	
    43		*val = readw(base + reg);
    44	
    45		return 0;
    46	}
    47	
    48	static const struct regmap_config gswip_core_regmap_config = {
    49		.reg_bits = 16,
    50		.val_bits = 16,
    51		.reg_stride = 4,
    52		.reg_write = regmap_reg_write,
    53		.reg_read = regmap_reg_read,
    54		.fast_io = true,
    55	};
    56	
    57	static int np_gswip_parse_dt(struct platform_device *pdev,
    58				     struct gswip_priv *priv)
    59	{
    60		struct device *dev = &pdev->dev;
    61		struct device_node *node = dev->of_node;
    62		struct gswip_pdata *pdata = &priv->pdata;
    63		struct device_node *np;
    64		void __iomem *core;
    65	
    66		pdata->sw = devm_platform_ioremap_resource_byname(pdev, "switch");
    67		if (IS_ERR(pdata->sw))
    68			return PTR_ERR(pdata->sw);
    69	
    70		pdata->lmac = devm_platform_ioremap_resource_byname(pdev, "lmac");
    71		if (IS_ERR(pdata->lmac))
    72			return PTR_ERR(pdata->lmac);
    73	
    74		core = devm_platform_ioremap_resource_byname(pdev, "core");
    75		if (IS_ERR(core))
    76			return PTR_ERR(core);
  > 77		pdata->core_regmap = devm_regmap_init(dev, NULL, core,
    78						      &gswip_core_regmap_config);
    79		if (IS_ERR(pdata->core_regmap))
    80			return PTR_ERR(pdata->core_regmap);
    81	
    82		pdata->sw_irq = platform_get_irq_byname(pdev, "switch");
    83		if (pdata->sw_irq < 0) {
    84			dev_err(dev, "switch irq not found\n");
    85			return -ENODEV;
    86		}
    87	
    88		pdata->core_irq = platform_get_irq_byname(pdev, "core");
    89		if (pdata->core_irq < 0) {
    90			dev_err(dev, "core irq not found\n");
    91			return -ENODEV;
    92		}
    93	
    94		pdata->ptp_clk = devm_clk_get(dev, "ptp");
    95		if (IS_ERR(pdata->ptp_clk))
    96			return PTR_ERR(pdata->ptp_clk);
    97	
    98		pdata->sw_clk = devm_clk_get(dev, "switch");
    99		if (IS_ERR(pdata->sw_clk))
   100			return PTR_ERR(priv->pdata.sw_clk);
   101	
   102		for_each_node_by_name(node, GSWIP_MAC_DEV_NAME) {
   103			priv->num_subdev_mac++;
   104			if (priv->num_subdev_mac > GSWIP_SUBDEV_MAC_MAX) {
   105				dev_err(dev, "too many GSWIP mac subdevices\n");
   106				return -EINVAL;
   107			}
   108		}
   109	
   110		if (!priv->num_subdev_mac) {
   111			dev_err(dev, "GSWIP mac subdevice not found\n");
   112			return -EINVAL;
   113		}
   114	
   115		np = of_find_node_by_name(node, GSWIP_CORE_DEV_NAME);
   116		if (np) {
   117			priv->num_subdev_core++;
   118			of_node_put(np);
   119		} else {
   120			dev_err(dev, "GSWIP core subdevice not found\n");
   121			return -EINVAL;
   122		}
   123	
   124		return 0;
   125	}
   126	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
