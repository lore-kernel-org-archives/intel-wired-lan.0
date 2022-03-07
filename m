From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 7 Mar 2022 15:53:19 +0300
Subject: [Intel-wired-lan] [bug report] ice: add TTY for GNSS module for
 E810T device
Message-ID: <20220307125319.GA16609@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Karol Kolacinski,

This is a semi-automatic email about new static checker warnings.

The patch 43113ff73453: "ice: add TTY for GNSS module for E810T 
device" from Mar 1, 2022, leads to the following Smatch complaint:

    drivers/net/ethernet/intel/ice/ice_gnss.c:101 ice_gnss_read()
    error: we previously assumed 'pf' could be null (see line 30)

drivers/net/ethernet/intel/ice/ice_gnss.c
    29		pf = gnss->back;
    30		if (!pf || !gnss->tty || !gnss->tty->port) {
                    ^^^
Check for NULL

    31			err = -EFAULT;
    32			goto exit;
    33		}
    34	
    35		hw = &pf->hw;
    36		port = gnss->tty->port;
    37	
    38		buf = (char *)get_zeroed_page(GFP_KERNEL);
    39		if (!buf) {
    40			err = -ENOMEM;
    41			goto exit;
    42		}
    43	
    44		memset(&link_topo, 0, sizeof(struct ice_aqc_link_topo_addr));
    45		link_topo.topo_params.index = ICE_E810T_GNSS_I2C_BUS;
    46		link_topo.topo_params.node_type_ctx |=
    47			FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M,
    48				   ICE_AQC_LINK_TOPO_NODE_CTX_OVERRIDE);
    49	
    50		i2c_params = ICE_GNSS_UBX_DATA_LEN_WIDTH |
    51			     ICE_AQC_I2C_USE_REPEATED_START;
    52	
    53		/* Read data length in a loop, when it's not 0 the data is ready */
    54		for (i = 0; i < ICE_MAX_UBX_READ_TRIES; i++) {
    55			err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
    56					      cpu_to_le16(ICE_GNSS_UBX_DATA_LEN_H),
    57					      i2c_params, (u8 *)&data_len_b, NULL);
    58			if (err)
    59				goto exit_buf;
    60	
    61			data_len = be16_to_cpu(data_len_b);
    62			if (data_len != 0 && data_len != U16_MAX)
    63				break;
    64	
    65			mdelay(10);
    66		}
    67	
    68		data_len = min(data_len, (u16)PAGE_SIZE);
    69		data_len = tty_buffer_request_room(port, data_len);
    70		if (!data_len) {
    71			err = -ENOMEM;
    72			goto exit_buf;
    73		}
    74	
    75		/* Read received data */
    76		for (i = 0; i < data_len; i += bytes_read) {
    77			u16 bytes_left = data_len - i;
    78	
    79			bytes_read = bytes_left < ICE_MAX_I2C_DATA_SIZE ? bytes_left :
    80						  ICE_MAX_I2C_DATA_SIZE;
    81	
    82			err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
    83					      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
    84					      bytes_read, &buf[i], NULL);
    85			if (err)
    86				goto exit_buf;
    87		}
    88	
    89		/* Send the data to the tty layer for users to read. This doesn't
    90		 * actually push the data through unless tty->low_latency is set.
    91		 */
    92		tty_insert_flip_string(port, buf, i);
    93		tty_flip_buffer_push(port);
    94	
    95	exit_buf:
    96		free_page((unsigned long)buf);
    97		kthread_queue_delayed_work(gnss->kworker, &gnss->read_work,
    98					   ICE_GNSS_TIMER_DELAY_TIME);
    99	exit:
   100		if (err)
   101			dev_dbg(ice_pf_to_dev(pf), "GNSS failed to read err=%d\n", err);
                                              ^^
Unchecked dereference

   102	}
   103	

regards,
dan carpenter
