From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 14 Jun 2018 09:25:00 +0900
Subject: [Intel-wired-lan] [PATCH net-queue] i40e: Fix incorrect skb
 reserved size on rx
In-Reply-To: <8ec63217-2aab-b240-ce95-530e5f1c1f15@iogearbox.net>
References: <1528877310-2574-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <8ec63217-2aab-b240-ce95-530e5f1c1f15@iogearbox.net>
Message-ID: <8963a38e-0583-1a3f-bcfe-8a62d5da6dbf@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/06/13 18:06, Daniel Borkmann wrote:
> On 06/13/2018 10:08 AM, Toshiaki Makita wrote:
>> i40e_build_skb() reserves I40E_SKB_PAD + (xdp->data -
>> xdp->data_hard_start) but obviously I40E_SKB_PAD is unnecessary here
>> and mac_header/data feilds in skb becomes incorrect, and breaks normal
>> skb receive path as well as XDP receive path.
>>
>> Fixes: cc5b114dcf98 ("bpf, i40e: add meta data support")
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> 
> Thanks Toshiaki, I sent a complete fix yesterday here:
> 
> https://lkml.org/lkml/2018/6/12/843

Oh I was not aware of it. Thanks, let's go with your patch.

-- 
Toshiaki Makita

