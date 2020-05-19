From: kbuild test robot <lkp@intel.com>
Date: Wed, 20 May 2020 03:06:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 105/183]
 sound/soc/sof/intel/apl.c:167:1: error: type defaults to 'int' in
 declaration of 'MODULE_IMPORT_NS'
Message-ID: <202005200349.7ZATWxlp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c7dd63d321082aff5fb170d27beab8a756e3434
commit: aee46c9d07a0bd4fcc62eeed627fe4f8a0946d50 [105/183] ASoC: SOF: ops: Add new op for client registration
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout aee46c9d07a0bd4fcc62eeed627fe4f8a0946d50
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

sound/soc/sof/intel/apl.c:167:1: warning: data definition has no type or storage class
167 | MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);
| ^~~~~~~~~~~~~~~~
>> sound/soc/sof/intel/apl.c:167:1: error: type defaults to 'int' in declaration of 'MODULE_IMPORT_NS' [-Werror=implicit-int]
sound/soc/sof/intel/apl.c:167:1: warning: parameter names (without types) in function declaration
cc1: some warnings being treated as errors
--
sound/soc/sof/intel/cnl.c:444:1: warning: data definition has no type or storage class
444 | MODULE_IMPORT_NS(SND_SOC_SOF_CLIENT);
| ^~~~~~~~~~~~~~~~
>> sound/soc/sof/intel/cnl.c:444:1: error: type defaults to 'int' in declaration of 'MODULE_IMPORT_NS' [-Werror=implicit-int]
sound/soc/sof/intel/cnl.c:444:1: warning: parameter names (without types) in function declaration
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
Size: 62521 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200520/2d3bcd70/attachment-0001.bin>
