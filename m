From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 17 Mar 2021 16:23:39 +0300
Subject: [Intel-wired-lan] [bug report] igc: Add NVM support
Message-ID: <YFIC27QOoIaVkDYL@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Sasha Neftin,

The patch ab4056126813: "igc: Add NVM support" from Oct 11, 2018,
leads to the following static checker warning:

	drivers/net/ethernet/intel/igc/igc_i225.c:235 igc_write_nvm_srwr()
	warn: loop overwrites return value 'ret_val'

drivers/net/ethernet/intel/igc/igc_i225.c
   218  static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
   219                                u16 *data)
   220  {
   221          struct igc_nvm_info *nvm = &hw->nvm;
   222          s32 ret_val = -IGC_ERR_NVM;
   223          u32 attempts = 100000;
   224          u32 i, k, eewr = 0;
   225  
   226          /* A check for invalid values:  offset too large, too many words,
   227           * too many words for the offset, and not enough words.
   228           */
   229          if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
   230              words == 0) {
   231                  hw_dbg("nvm parameter(s) out of bounds\n");
   232                  goto out;

I really don't care for "goto out;" labels.  They add a level of
misdirection and ambiguity.  This should be "return -EINVAL;" instead
of "return -IGC_ERR_NVM;".  Eventually it gets propogated back to the
user via dev_ethtool() and it becomes -EPERM to the user.

   233          }
   234  
   235          for (i = 0; i < words; i++) {
   236                  eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
   237                          (data[i] << IGC_NVM_RW_REG_DATA) |
   238                          IGC_NVM_RW_REG_START;
   239  
   240                  wr32(IGC_SRWR, eewr);
   241  
   242                  for (k = 0; k < attempts; k++) {
   243                          if (IGC_NVM_RW_REG_DONE &
   244                              rd32(IGC_SRWR)) {
   245                                  ret_val = 0;
   246                                  break;
   247                          }
   248                          udelay(5);
   249                  }
   250  
   251                  if (ret_val) {
   252                          hw_dbg("Shadow RAM write EEWR timed out\n");
   253                          break;
   254                  }

If there is a read error on subsequent iterations through the loop then
this code will return success.

   255          }
   256  
   257  out:
   258          return ret_val;
   259  }

regards,
dan carpenter
