From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 5 Jan 2017 14:05:54 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3] i40e/i40evf: Update
 driver to support napi_complete_done changes
In-Reply-To: <CAKgT0UeScCSh0uJBNRzQ9V-yrdqQFq1mU1PdE4xwFpYwWxSWNA@mail.gmail.com>
References: <20161208001248.13098.93773.stgit@localhost.localdomain>
 <CAKgT0UeScCSh0uJBNRzQ9V-yrdqQFq1mU1PdE4xwFpYwWxSWNA@mail.gmail.com>
Message-ID: <CAKgT0UfYdF46QUt32gqsBpY777Vzrt9HbWUMsEW0WNeVnGr=9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 5, 2017 at 2:05 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Wed, Dec 7, 2016 at 4:14 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> Recently napi_complete_done was updated so that it will return zero if we
>> are using the queue vector for busy polling.  When this is the case we
>> don't need to re-enable interrupts as the busy polling will reschedule the
>> NAPI instance when it is finally done polling.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>>
>> v2: Updated code to place the IRQ enabling inside the if statment
>>     This made it so that we are consistent with the recent return value changes
>>
>> v3: Added i40evf changes as well
>>
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   32 +++++++++++++------------
>>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   28 ++++++++++++----------
>>  2 files changed, 32 insertions(+), 28 deletions(-)
>>
>
> Jeff,
>
> This patch causes a performance regression due to the way it interacts
> with the i40e WB on ITR behavior.  Can you please drop it from the
> dev-queue.
>
> Thanks.
>
> - Alex

Re-sending this time and making sure it is sent to Jeff.

Thanks.

- Alex
