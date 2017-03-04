From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 3 Mar 2017 17:28:02 -0800
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe: use xdp_buff to simplify
	call path
In-Reply-To: <CAKgT0UepgwiJKhATn9oDzs8wAiPAZKkTpTaE3di6JZT1_aJYGw@mail.gmail.com>
References: <20170303210437.13969.48559.stgit@john-Precision-Tower-5810>
 <CAKgT0UepgwiJKhATn9oDzs8wAiPAZKkTpTaE3di6JZT1_aJYGw@mail.gmail.com>
Message-ID: <58BA1822.2070309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-03-03 04:29 PM, Alexander Duyck wrote:
> On Fri, Mar 3, 2017 at 1:04 PM, John Fastabend <john.fastabend@gmail.com> wrote:
>> Alex, is this what you are thinking w.r.t. pushing the xdp_buff
>> through the ixgbe skb build routines. It seems to look OK but
>> only lightly tested for now.
>>
>> I hvaen't decided if I want to push it into the first set of
>> patches or as a 4th patch.
> 
> Yeah, this is more or less what I was thinking.  Basically we just end
> up pulling most of the rx_buffer_info structure onto the stack and
> then process it there.  If we folded it into the other patches it
> might actually make them a bit smaller since this patch is having to
> go through and unto a number of things those patches are doing.
> 


Yeah, I'll fold it in Monday and address the couple other comments.
Then I think we are probably good.

