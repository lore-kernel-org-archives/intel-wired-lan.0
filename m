From: Shannon Nelson <snelson@pensando.io>
Date: Thu, 12 Sep 2019 18:54:10 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix secpath usage for IPsec TX
 offload.
In-Reply-To: <9d94bd04-c6fa-d275-97bc-5d589304f038@reliablehosting.com>
References: <20190912110144.GS2879@gauss3.secunet.de>
 <9d94bd04-c6fa-d275-97bc-5d589304f038@reliablehosting.com>
Message-ID: <21ead3ce-25d8-8be8-d7e6-46450fcd38b8@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/12/19 5:33 PM, Jonathan Tooker wrote:
> On 9/12/2019 6:01 AM, Steffen Klassert wrote:
>> The ixgbe driver currently does IPsec TX offloading
>> based on an existing secpath. However, the secpath
>> can also come from the RX side, in this case it is
>> misinterpreted for TX offload and the packets are
>> dropped with a "bad sa_idx" error. Fix this by using
>> the xfrm_offload() function to test for TX offload.
>>
> Does this patch also need to be ported to the ixgbevf driver? I can 
> replicate the bad sa_idx error using a VM that's using a VF & the 
> ixgebvf? driver.
>

Yes.
sln
