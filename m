From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 4 Sep 2018 08:32:39 -0700
Subject: [Intel-wired-lan] [bug report] ixgbevf: add VF IPsec offload
 code
In-Reply-To: <20180831172952.ndpg56fhftpnxzsk@kili.mountain>
References: <20180831172952.ndpg56fhftpnxzsk@kili.mountain>
Message-ID: <a5b2e5fa-2285-6b9f-c529-672311e6fe70@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/31/2018 10:29 AM, Dan Carpenter wrote:
> Hello Shannon Nelson,
> 
> The patch 0062e7cc955e: "ixgbevf: add VF IPsec offload code" from Aug
> 13, 2018, leads to the following static checker warning:
> 
> 	drivers/net/ethernet/intel/ixgbevf/mbx.c:244 ixgbevf_write_mbx_vf()
> 	warn: potential pointer math issue ('msg' is a 32 bit pointer)
> 
> [ This is an unpublished smatch check.  The warning message isn't very
>    good.  What it's trying to warn about here is the difference between
>    ARRAY_SIZE() and sizeof().  - dan ]

Thanks for finding this, Dan.  I'll send up a fix.
sln

> 
> drivers/net/ethernet/intel/ixgbevf/ipsec.c
>      18  static int ixgbevf_ipsec_set_pf_sa(struct ixgbevf_adapter *adapter,
>      19                                     struct xfrm_state *xs)
>      20  {
>      21          u32 msgbuf[IXGBE_VFMAILBOX_SIZE] = { 0 };
>      22          struct ixgbe_hw *hw = &adapter->hw;
>      23          struct sa_mbx_msg *sam;
>      24          u16 msglen;
>      25          int ret;
>      26
>      27          /* send the important bits to the PF */
>      28          sam = (struct sa_mbx_msg *)(&msgbuf[1]);
>      29          sam->flags = xs->xso.flags;
>      30          sam->spi = xs->id.spi;
>      31          sam->proto = xs->id.proto;
>      32          sam->family = xs->props.family;
>      33
>      34          if (xs->props.family == AF_INET6)
>      35                  memcpy(sam->addr, &xs->id.daddr.a6, sizeof(xs->id.daddr.a6));
>      36          else
>      37                  memcpy(sam->addr, &xs->id.daddr.a4, sizeof(xs->id.daddr.a4));
>      38          memcpy(sam->key, xs->aead->alg_key, sizeof(sam->key));
>      39
>      40          msgbuf[0] = IXGBE_VF_IPSEC_ADD;
>      41          msglen = sizeof(*sam) + sizeof(msgbuf[0]);
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      42
>      43          spin_lock_bh(&adapter->mbx_lock);
>      44
>      45          ret = hw->mbx.ops.write_posted(hw, msgbuf, msglen);
>                                                             ^^^^^^
> This is in byte terms but it should be in terms of sizeof(u32).
> 
>      46          if (ret)
>      47                  goto out;
>      48
>      49          msglen = sizeof(msgbuf[0]) * 2;
>      50          ret = hw->mbx.ops.read_posted(hw, msgbuf, msglen);
>                                                            ^^^^^^
>      51          if (ret)
>      52                  goto out;
>      53
>      54          ret = (int)msgbuf[1];
>      55          if (msgbuf[0] & IXGBE_VT_MSGTYPE_NACK && ret >= 0)
>      56                  ret = -1;
>      57
>      58  out:
>      59          spin_unlock_bh(&adapter->mbx_lock);
>      60
>      61          return ret;
>      62  }
>      63
>      64  /**
>      65   * ixgbevf_ipsec_del_pf_sa - ask the PF to delete an SA
>      66   * @adapter: board private structure
>      67   * @pfsa: sa index returned from PF when created, -1 for all
>      68   *
>      69   * Returns: 0 on success, or negative error code
>      70   **/
>      71  static int ixgbevf_ipsec_del_pf_sa(struct ixgbevf_adapter *adapter, int pfsa)
>      72  {
>      73          struct ixgbe_hw *hw = &adapter->hw;
>      74          u32 msgbuf[2];
>      75          int err;
>      76
>      77          memset(msgbuf, 0, sizeof(msgbuf));
>      78          msgbuf[0] = IXGBE_VF_IPSEC_DEL;
>      79          msgbuf[1] = (u32)pfsa;
>      80
>      81          spin_lock_bh(&adapter->mbx_lock);
>      82
>      83          err = hw->mbx.ops.write_posted(hw, msgbuf, sizeof(msgbuf));
>                                                             ^^^^^^^^^^^^^^
> This should be 2
> 
>      84          if (err)
>      85                  goto out;
>      86
>      87          err = hw->mbx.ops.read_posted(hw, msgbuf, sizeof(msgbuf));
>                                                            ^^^^^^^^^^^^^
> 2 elements here also.  (This static checker warning is not published
> because it's low quality, so take it all with a grain of salt etc).
> 
>      88          if (err)
>      89                  goto out;
>      90
>      91  out:
>      92          spin_unlock_bh(&adapter->mbx_lock);
>      93          return err;
>      94  }
> 
> regards,
> dan carpenter
> 
