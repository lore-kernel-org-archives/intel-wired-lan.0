From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 1 Feb 2017 13:32:40 -0800
Subject: [Intel-wired-lan] [PATCH v4 0/4] i40e: Support for XDP
In-Reply-To: <CAJ+HfNjOBm5MMbAgUk4KRdKdmn66n+M807grhkJ5s+dZi3uAQA@mail.gmail.com>
References: <20161217134000.31640-1-bjorn.topel@gmail.com>
 <CAKgT0Ue5k8YGt1U_9vTM8ZKac-ryiDJ+zapZFuxLkRpdQKTTOw@mail.gmail.com>
 <CAJ+HfNjOBm5MMbAgUk4KRdKdmn66n+M807grhkJ5s+dZi3uAQA@mail.gmail.com>
Message-ID: <CAKgT0UdZiMPPab-2v_0yvVqc7uA+uYNGAfu36WXvfETxah_B_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 31, 2017 at 2:30 PM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> 2017-01-31 22:37 GMT+01:00 Alexander Duyck <alexander.duyck@gmail.com>:
>> We probably need to respin this and do a v5 of the XDP code so that we
>> can reserve some headroom at the start of the frames.  I have patches
>> I already working on to enable build_skb like I have done for igb and
>> ixgbe.  I can probably take on respinning this and getting it applied
>> to our out-of-tree driver.
>
> Respinning or an additional patch for the xdp_adjust_head()
> support? Maybe it's better to respin it, so we get proper
> xdp_adjust_head() support, prior upstreaming.

It makes the upstreaming process easier for us since we normally work
out of tree and then upstream patches after testing in the case of
i40e.

> If headroom support for XDP aligns nicely into your build_skb
> patches for i40e, feel free to do that! If not, let me know, and
> I'll start working on it.

Yeah, I'll be working on providing headroom in order to support
build_skb anyway so I can just combine the efforts.  Then it makes the
upstreaming effort easier as well as we will have the headroom added
before we actually start work on XDP.

Thanks.

- Alex
