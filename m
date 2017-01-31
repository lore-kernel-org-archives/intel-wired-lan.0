From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 31 Jan 2017 23:30:19 +0100
Subject: [Intel-wired-lan] [PATCH v4 0/4] i40e: Support for XDP
In-Reply-To: <CAKgT0Ue5k8YGt1U_9vTM8ZKac-ryiDJ+zapZFuxLkRpdQKTTOw@mail.gmail.com>
References: <20161217134000.31640-1-bjorn.topel@gmail.com>
 <CAKgT0Ue5k8YGt1U_9vTM8ZKac-ryiDJ+zapZFuxLkRpdQKTTOw@mail.gmail.com>
Message-ID: <CAJ+HfNjOBm5MMbAgUk4KRdKdmn66n+M807grhkJ5s+dZi3uAQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2017-01-31 22:37 GMT+01:00 Alexander Duyck <alexander.duyck@gmail.com>:
> We probably need to respin this and do a v5 of the XDP code so that we
> can reserve some headroom at the start of the frames.  I have patches
> I already working on to enable build_skb like I have done for igb and
> ixgbe.  I can probably take on respinning this and getting it applied
> to our out-of-tree driver.

Respinning or an additional patch for the xdp_adjust_head()
support? Maybe it's better to respin it, so we get proper
xdp_adjust_head() support, prior upstreaming.

If headroom support for XDP aligns nicely into your build_skb
patches for i40e, feel free to do that! If not, let me know, and
I'll start working on it.


Thanks for bringing this up!
Bj?rn



>
> - Alex
>
> On Sat, Dec 17, 2016 at 5:39 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> This series adds XDP support for i40e-based NICs.
>>
>> The first patch prepares i40e_fetch_rx_buffer() for upcoming changes,
>> followed by XDP_RX support, the third adds XDP_TX support and the last
>> patch validates bpf_xdp_adjust_head() support.
>>
>> Thanks to Alex, Daniel, John and Scott for all the feedback!
>>
>> v4:
>>   * Removed unused i40e_page_is_reserved function
>>   * Prior running the XDP program, set the struct xdp_buff
>>     data_hard_start member
>>
>> v3:
>>   * Rebased patch set on Jeff's dev-queue branch
>>   * MSI-X is no longer a prerequisite for XDP
>>   * RCU locking for the XDP program and XDP_RX support is introduced
>>     in the same patch
>>   * Rx bytes is now bumped for XDP
>>   * Removed pointer-to-pointer clunkiness
>>   * Added comments to XDP preconditions in ndo_xdp
>>   * When a non-EOF is received, log once, and drop the frame
>>
>> v2:
>>   * Fixed kbuild error for PAGE_SIZE >= 8192.
>>   * Renamed i40e_try_flip_rx_page to i40e_can_reuse_rx_page, which is
>>     more in line to the other Intel Ethernet drivers (igb/fm10k).
>>   * Validate xdp_adjust_head support in ndo_xdp/XDP_SETUP_PROG.
>>
>>
>> Bj?rn
>>
>>
>> Bj?rn T?pel (4):
>>   i40e: Sync DMA region prior skbuff allocation
>>   i40e: Initial support for XDP
>>   i40e: Add XDP_TX support
>>   i40e: Validate xdp_adjust_head support
>>
>>  drivers/net/ethernet/intel/i40e/i40e.h         |  18 ++
>>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   4 +
>>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 380 ++++++++++++++++++++----
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 383 ++++++++++++++++++++++---
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   7 +
>>  5 files changed, 703 insertions(+), 89 deletions(-)
>>
>> --
>> 2.9.3
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at lists.osuosl.org
>> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
