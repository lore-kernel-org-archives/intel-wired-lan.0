From: kernel test robot <lkp@intel.com>
Date: Fri, 28 Jan 2022 12:19:10 +0800
Subject: [Intel-wired-lan] [PATCH net-next 05/19] iecm: add vport alloc
 and virtchnl messages
In-Reply-To: <20220128001009.721392-6-alan.brady@intel.com>
References: <20220128001009.721392-6-alan.brady@intel.com>
Message-ID: <202201281200.CI9u45bS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Alan-Brady/Add-iecm-and-idpf/20220128-085513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git e2cf07654efb0fd7bbcb475c6f74be7b5755a8fd
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201281200.CI9u45bS-lkp at intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1233d9631b312eea5aebbce63590e27f9993bacc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alan-Brady/Add-iecm-and-idpf/20220128-085513
        git checkout 1233d9631b312eea5aebbce63590e27f9993bacc
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/iecm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/iecm/iecm_virtchnl.c: In function 'iecm_vport_queue_ids_init':
>> drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:1396:1: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1396 | }
         | ^


vim +1396 drivers/net/ethernet/intel/iecm/iecm_virtchnl.c

  1322	
  1323	/**
  1324	 * iecm_vport_queue_ids_init - Initialize queue ids from Mailbox parameters
  1325	 * @vport: virtual port for which the queues ids are initialized
  1326	 *
  1327	 * Will initialize all queue ids with ids received as mailbox parameters.
  1328	 * Returns 0 on success, negative if all the queues are not initialized.
  1329	 */
  1330	static int iecm_vport_queue_ids_init(struct iecm_vport *vport)
  1331	{
  1332		struct virtchnl2_create_vport *vport_params;
  1333		struct virtchnl2_queue_reg_chunks *chunks;
  1334		/* We may never deal with more than 256 same type of queues */
  1335	#define IECM_MAX_QIDS	256
  1336		u32 qids[IECM_MAX_QIDS];
  1337		int num_ids;
  1338		u16 q_type;
  1339	
  1340		if (vport->adapter->config_data.req_qs_chunks) {
  1341			struct virtchnl2_add_queues *vc_aq =
  1342				(struct virtchnl2_add_queues *)
  1343				vport->adapter->config_data.req_qs_chunks;
  1344			chunks = &vc_aq->chunks;
  1345		} else {
  1346			vport_params = (struct virtchnl2_create_vport *)
  1347					vport->adapter->vport_params_recvd[0];
  1348			chunks = &vport_params->chunks;
  1349		}
  1350	
  1351		num_ids = iecm_vport_get_queue_ids(qids, IECM_MAX_QIDS,
  1352						   VIRTCHNL2_QUEUE_TYPE_TX,
  1353						   chunks);
  1354		if (num_ids != vport->num_txq)
  1355			return -EINVAL;
  1356		num_ids = __iecm_vport_queue_ids_init(vport, qids, num_ids,
  1357						      VIRTCHNL2_QUEUE_TYPE_TX);
  1358		if (num_ids != vport->num_txq)
  1359			return -EINVAL;
  1360		num_ids = iecm_vport_get_queue_ids(qids, IECM_MAX_QIDS,
  1361						   VIRTCHNL2_QUEUE_TYPE_RX,
  1362						   chunks);
  1363		if (num_ids != vport->num_rxq)
  1364			return -EINVAL;
  1365		num_ids = __iecm_vport_queue_ids_init(vport, qids, num_ids,
  1366						      VIRTCHNL2_QUEUE_TYPE_RX);
  1367		if (num_ids != vport->num_rxq)
  1368			return -EINVAL;
  1369	
  1370		if (iecm_is_queue_model_split(vport->txq_model)) {
  1371			q_type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
  1372			num_ids = iecm_vport_get_queue_ids(qids, IECM_MAX_QIDS, q_type,
  1373							   chunks);
  1374			if (num_ids != vport->num_complq)
  1375				return -EINVAL;
  1376			num_ids = __iecm_vport_queue_ids_init(vport, qids,
  1377							      num_ids,
  1378							      q_type);
  1379			if (num_ids != vport->num_complq)
  1380				return -EINVAL;
  1381		}
  1382	
  1383		if (iecm_is_queue_model_split(vport->rxq_model)) {
  1384			q_type = VIRTCHNL2_QUEUE_TYPE_RX_BUFFER;
  1385			num_ids = iecm_vport_get_queue_ids(qids, IECM_MAX_QIDS, q_type,
  1386							   chunks);
  1387			if (num_ids != vport->num_bufq)
  1388				return -EINVAL;
  1389			num_ids = __iecm_vport_queue_ids_init(vport, qids, num_ids,
  1390							      q_type);
  1391			if (num_ids != vport->num_bufq)
  1392				return -EINVAL;
  1393		}
  1394	
  1395		return 0;
> 1396	}
  1397	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
