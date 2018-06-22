From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 22 Jun 2018 09:23:04 -0700
Subject: [Intel-wired-lan] igb: Problems with early PHY reset when using
 an SFP module with SGMII as phy->addr is unset
In-Reply-To: <98c8af132eae46318a4f3dee1d0306b6@infodas.de>
References: <98c8af132eae46318a4f3dee1d0306b6@infodas.de>
Message-ID: <CAKgT0Uc_fcCJTC56Q24Bi4A4+1kOh=-6hi_aDZjkfdvA2b0e+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 22, 2018 at 3:05 AM, Gr?nke, Christian <C.Groenke@infodas.de> wrote:
> Hello Aaron, Hello Jeff,
>
> I have problems with the newer versions of the e1000 (igb) driver of current kernels. I stumbled over this with a vendor kernel[*] after they pulled in some updates. When starting on my board, which has several i210 MACs connected to SFP ports. In case I use the hardware flashed for SGMII and SGMII capable SFP modules I see errors like this:
>
>> [ 4776.137522] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
>> [ 4776.137525] igb: Copyright (c) 2007-2014 Intel Corporation.
> [...]
>> [ 4776.337079] igb: probe of 0000:09:00.0 failed with error -3
>
> I tracked this down to the failing reset that was introduced by Aaron[*]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/intel/igb/e1000_82575.c?id=182785335447957409282ca745aa5bc3968facee
>> igb: reset the PHY before reading the PHY ID
>
> The problem here, at least for me, is that during this time in the initialization the phy->addr is '0' and thus 'e1000_write_phy_reg_sgmii_82575' fails. The SGMII PHY will only be discovered later on in 'igb_get_phy_id_82575'.
>
>> [ 4776.336987] igb: IGB: Soft resetting SGMII attached PHY...
>> [ 4776.336999] IGB: PHY I2C Address 0 is out of range.
>> [ 4776.337009] igb: IGB: Error resetting the PHY.
>
> When hacking the driver and presenting the PHY to the correct address, or doing a discovery of the PHY in case SGMII is active and MDIO is not used, it works. However, it seems a bit opposed to your patch. I understand your patch note in the way that in some cases the PHY has to be reset as otherwise the PHY ID can not be discovered and the "scan" would thus fail. May this inly be the case if SGMII is not used and thus 'igb_phy_hw_reset' would normally be called? It seems that in case SGMII is used the phy->addr has to be known to do a reset.
>
> I know too little about all the possible IGB/i210 configuration to judge what is okay here. This is why I wanted to get in touch. I am not sure what would be the right fix. While I can fix it for myself and our product by disabling your patch and have no reset, I would much prefer an upstream fix that I can backport.
>
> Kind regards
> Christian
>
> [*] Note: This is still the case in the most current driver on the master branch.
> [*] Note2: I first observed this on a L4Linux 4.9 (https://l4linux.org/) running on L4RE. However, I can also reproduce this with a current CentOS 7.5 which has a 3.10++ kernel and a Ubuntu 18.04.
>
> --
>
> Christian GR?NKE

Hi Christian,

Looking over the code I would say it is probably acceptable to just
revert the patch. In addition you could also probably revert commit
440aeca4b985 "igb: Explicitly select page 0 at initialization". Both
of those patches seem to be redundant as this was also fixed via a
third commit 4e684f59d760 "igb: Workaround for igb i210 firmware
issue" which I feel did a much better job of addressing the issue
without introducing other side effects.

If you want to submit the patches to revert the first commit you
mentioned, and the one I mentioned I would be willing to ack it and
see if we can get it pushed through the tree.

Thanks.

- Alex
