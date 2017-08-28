From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Aug 2017 09:25:46 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: apply burst mode settings
 only on default
In-Reply-To: <291b863f-552e-2f3b-f658-e812d0848949@intel.com>
References: <20170825150626.2843-1-willemdebruijn.kernel@gmail.com>
 <291b863f-552e-2f3b-f658-e812d0848949@intel.com>
Message-ID: <CAKgT0UctVUqAU7XAoiDOm8dSB20dFT+75qDpn2u4kyJDZ-Usyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Aug 27, 2017 at 1:30 AM, Neftin, Sasha <sasha.neftin@intel.com> wrote:
> On 8/25/2017 18:06, Willem de Bruijn wrote:
>>
>> From: Willem de Bruijn <willemb@google.com>
>>
>> Devices that support FLAG2_DMA_BURST have different default values
>> for RDTR and RADV. Apply burst mode default settings only when no
>> explicit value was passed at module load.
>>
>> The RDTR default is zero. If the module is loaded for low latency
>> operation with RxIntDelay=0, do not override this value with a burst
>> default of 32.
>>
>> Move the decision to apply burst values earlier, where explicitly
>> initialized module variables can be distinguished from defaults.
>>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> This patch looks good for me, but I would like hear second opinion.

This code is an improvement over what was already there. I am good with this.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
