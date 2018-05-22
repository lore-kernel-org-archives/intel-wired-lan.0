From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 May 2018 13:03:09 -0700
Subject: [Intel-wired-lan] Regression: Approximate 34% performance hit
 in receive throughput over ixgbe seen due to build_skb patch
In-Reply-To: <4F646FBB-FE0B-4FEE-98E5-3CA2DF0598DE@oracle.com>
References: <A940030A-CDBF-41CD-816F-0BBC76E7C4F4@oracle.com>
 <CAKgT0Ud2qriAkWcs56WEkw2vhYzBbWvzZOoY24ndsqPKaWn=Sg@mail.gmail.com>
 <4F646FBB-FE0B-4FEE-98E5-3CA2DF0598DE@oracle.com>
Message-ID: <CAKgT0Ud8V-5iWJoN_xSqmiZFArrpOiu2BM1Ldj_AaPhGdhiwBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 22, 2018 at 12:29 PM, William Kucharski
<william.kucharski@oracle.com> wrote:
>
>
>> On May 22, 2018, at 12:23 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>
>> 3. There should be a private flag that can be updated via "ethtool
>> --set-priv-flags" called "legacy-rx" that you can enable that will
>> roll back to the original that did the copy-break type approach for
>> small packets and the headers of the frame.
>
> With legacy-rx enabled, most of the regression goes away, but it's still present
> as compared to the code without the patch; the regression then drops to about 6%:
>
> # ethtool --show-priv-flags eno1
> Private flags for eno1:
> legacy-rx: on
>
> Socket  Message  Elapsed      Messages
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
>
>  65536      64   60.00     35934709      0     306.64
>  65536           60.00     33791739            288.35
>
> Socket  Message  Elapsed      Messages
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
>
>  65536      64   60.00     39254351      0     334.97
>  65536           60.00     36761069            313.69
>
> Is this variance to be expected, or do you think modification of the
> interrupt delay would achieve better results?
>
>
>     William Kucharski
>

I would think with modification of interrupt delay you could probably
do much better if my assumption is correct and the issue is us sitting
on packets for too long so we overrun the socket buffer and start
dropping packets or stalling the Tx.

Thanks.

- Alex
