From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 22 Mar 2016 23:04:32 +0300
Subject: [Intel-wired-lan] i40e: Add support for client interface for
	IWARP driver
Message-ID: <20160322200432.GB27995@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Anjali Singhai Jain,

The patch e3219ce6a775: "i40e: Add support for client interface for
IWARP driver" from Jan 20, 2016, leads to the following static
checker warning:

	drivers/net/ethernet/intel/i40e/i40e_client.c:752 i40e_client_setup_qvlist()
	error: potential null dereference 'ldev->qvlist_info'.  (kzalloc returns null)

drivers/net/ethernet/intel/i40e/i40e_client.c
   739  static int i40e_client_setup_qvlist(struct i40e_info *ldev,
   740                                      struct i40e_client *client,
   741                                      struct i40e_qvlist_info *qvlist_info)
   742  {
   743          struct i40e_pf *pf = ldev->pf;
   744          struct i40e_hw *hw = &pf->hw;
   745          struct i40e_qv_info *qv_info;
   746          u32 v_idx, i, reg_idx, reg;
   747          u32 size;
   748  
   749          size = sizeof(struct i40e_qvlist_info) +
   750                 (sizeof(struct i40e_qv_info) * (qvlist_info->num_vectors - 1));
   751          ldev->qvlist_info = kzalloc(size, GFP_KERNEL);

Need a check for NULL.

   752          ldev->qvlist_info->num_vectors = qvlist_info->num_vectors;
   753  
   754          for (i = 0; i < qvlist_info->num_vectors; i++) {
   755                  qv_info = &qvlist_info->qv_info[i];
   756                  if (!qv_info)
   757                          continue;
   758                  v_idx = qv_info->v_idx;

Also:

    drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:425 i40e_config_iwarp_qvlist()
    error: potential null dereference 'vf->qvlist_info'.  (kzalloc returns null)

regards,
dan carpenter
