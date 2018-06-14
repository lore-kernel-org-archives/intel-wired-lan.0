From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 14 Jun 2018 18:21:03 +0900
Subject: [Intel-wired-lan] [PATCH net-queue] i40e: Fix incorrect skb
 reserved size on rx
In-Reply-To: <FA03331EB45A2544B0CBCB1A14B6429E2B2A3ED7@IRSMSX104.ger.corp.intel.com>
References: <1528877310-2574-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <8ec63217-2aab-b240-ce95-530e5f1c1f15@iogearbox.net>
 <8963a38e-0583-1a3f-bcfe-8a62d5da6dbf@lab.ntt.co.jp>
 <FA03331EB45A2544B0CBCB1A14B6429E2B2A3ED7@IRSMSX104.ger.corp.intel.com>
Message-ID: <598ccdb7-ad88-f0ee-4b94-761f9beba64b@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/06/14 18:14, Malek, Patryk wrote:
>> On 2018/06/13 18:06, Daniel Borkmann wrote:
>>> On 06/13/2018 10:08 AM, Toshiaki Makita wrote:
>>>> i40e_build_skb() reserves I40E_SKB_PAD + (xdp->data -
>>>> xdp->data_hard_start) but obviously I40E_SKB_PAD is unnecessary
>> here
>>>> and mac_header/data feilds in skb becomes incorrect, and breaks
> 
> Shouldn't this be fields instead of feilds?

Thanks, but this is now superseded by Daniel's patch so dropped I think.
http://patchwork.ozlabs.org/patch/928778/

-- 
Toshiaki Makita

