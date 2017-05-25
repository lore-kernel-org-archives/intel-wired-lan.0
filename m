From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 25 May 2017 12:28:02 +0200
Subject: [Intel-wired-lan] [PATCH v7 0/2] i40e: support for XDP
In-Reply-To: <CAKgT0Ud6fRk2VQ=tc5rPMarD+MM1uXMqU701K6++ti4ufi6DdA@mail.gmail.com>
References: <20170524055535.14155-1-bjorn.topel@gmail.com>
 <CAKgT0Ud6fRk2VQ=tc5rPMarD+MM1uXMqU701K6++ti4ufi6DdA@mail.gmail.com>
Message-ID: <5926B1B2.5050605@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/24/2017 06:31 PM, Alexander Duyck wrote:
> This series looks good to me.
>
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
>
> On Tue, May 23, 2017 at 10:55 PM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> This series adds XDP support for i40e-based NICs.

Awesome, very nice! Will these land this net-next cycle? :)

>> The first patch wires up ndo_xdp and implements XDP_DROP semantics for
>> all actions. The second patch adds egress support via the XDP_TX
>> action.
>>
>> Performance numbers (40GbE port, 64B packets) for xdp1 and xdp2
>> programs, from samples/bpf/:
>>
>>   IOMMU                      | xdp1      | xdp2
>>   ---------------------------+-----------+-----------
>>   iommu=off                  | 29.7 Mpps | 17.1 Mpps
>>   iommu=pt intel_iommu=on    | 29.7 Mpps | 11.6 Mpps
>>   iommu=on intel_iommu=on    | 21.8 Mpps |  3.7 Mpps
>>
>> Future improvements, not covered by the patches:
>>    * Proper debugfs support.
>>    * i40evf support.
