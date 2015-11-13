From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 13 Nov 2015 13:18:47 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle extended IPv6 headers
 in tx path
In-Reply-To: <305E19FFAC908240AB6DEBD1E2D8C1E180C17A68@ORSMSX108.amr.corp.intel.com>
References: <20151105010227.984.84717.stgit@mdrustad-wks.jf.intel.com>
 <305E19FFAC908240AB6DEBD1E2D8C1E180C17A68@ORSMSX108.amr.corp.intel.com>
Message-ID: <564653B7.90100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/13/2015 12:55 PM, Schmitt, Phillip J wrote:
>
>> -----Original Message-----
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>> Behalf Of Mark D Rustad
>> Sent: Wednesday, November 04, 2015 5:02 PM
>> To: intel-wired-lan at lists.osuosl.org
>> Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle extended IPv6 headers in tx
>> path
>>
>> Check for and handle IPv6 extended headers so that tx checksum offload can be
>> done. Thanks to Tom Herbert for noticing this problem. Note that the goto back
>> to process the final protocol value can never result in a loop, because it cannot
>> be yet another extended header. Handling them in this manner avoids adding
>> further checks to the non-extended header hot path.
>>
>> Reported-by: Tom Herbert <tom@herbertland.com>
>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

What protocol types did you test this over?  Just curious as it seems it 
is using ip6_find_header without taking into account if we want the 
inner or outer IPv6 header.

I believe in order to get that correct there should be an offset taken 
into account so that the inner header could be found instead of the 
outer in case skb->encapsulation is set.

- Alex
