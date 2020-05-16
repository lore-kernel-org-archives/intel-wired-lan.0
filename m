From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 May 2020 17:09:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 105/115]
 sound/soc/sof/intel/apl.c:167:1: error: type defaults to 'int' in
 declaration of 'MODULE_IMPORT_NS'
Message-ID: <202005161723.4iixD7Z2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1ae51690bc317eb011c6fcc8f5549b151b347167
commit: 2f4dd43456871c929a14c14aed8999a2abef8592 [105/115] ASoC: SOF: ops: Add new op for client registration
config: parisc-allyesconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2f4dd43456871c929a14c14aed8999a2abef8592
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

sound/soc/sof/intel/apl.c:167:1: warning: data definition has no type or storage class
167 | MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);
| ^~~~~~~~~~~~~~~~
>> sound/soc/sof/intel/apl.c:167:1: error: type defaults to 'int' in declaration of 'MODULE_IMPORT_NS' [-Werror=implicit-int]
sound/soc/sof/intel/apl.c:167:1: warning: parameter names (without types) in function declaration
cc1: some warnings being treated as errors

vim +167 sound/soc/sof/intel/apl.c

   151	
   152	const struct sof_intel_dsp_desc apl_chip_info = {
   153		/* Apollolake */
   154		.cores_num = 2,
   155		.init_core_mask = 1,
   156		.cores_mask = HDA_DSP_CORE_MASK(0) | HDA_DSP_CORE_MASK(1),
   157		.ipc_req = HDA_DSP_REG_HIPCI,
   158		.ipc_req_mask = HDA_DSP_REG_HIPCI_BUSY,
   159		.ipc_ack = HDA_DSP_REG_HIPCIE,
   160		.ipc_ack_mask = HDA_DSP_REG_HIPCIE_DONE,
   161		.ipc_ctl = HDA_DSP_REG_HIPCCTL,
   162		.rom_init_timeout	= 150,
   163		.ssp_count = APL_SSP_COUNT,
   164		.ssp_base_offset = APL_SSP_BASE_OFFSET,
   165	};
   166	EXPORT_SYMBOL_NS(apl_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
 > 167	MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61670 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200516/39666202/attachment-0001.bin>
