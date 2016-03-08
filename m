From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 8 Mar 2016 12:38:46 -0800
Subject: [Intel-wired-lan] [next PATCH v2] i40e/i40evf: Allow up to 12K
 bytes of data per Tx descriptor instead of 8K
In-Reply-To: <20160308114717.000053d3@unknown>
References: <20160219201130.16927.24329.stgit@localhost.localdomain>
 <20160308114717.000053d3@unknown>
Message-ID: <CAKgT0Uf2qmrmvinXvJw+dvmXZTXnB_3YVu0aa9_Jrs4tEQxS-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 8, 2016 at 11:47 AM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> Thanks Alex, a couple minor comments.
>
> As an aside, it would be interesting to know if there is a way to get
> 25us tx-ITR single stream performance while not using so much CPU when
> multiple threads get involved.

The 25us value is really meant to just be a single thread performance
test.  For multiple threads you can start cutting back on that value,
but the results become harder to predict as there are more variables
in play.  Basically the idea behind the 25us is that we have to be
cleaning the Tx and Rx ring fast enough to avoid letting them go empty
for any period of time.

> On Fri, 19 Feb 2016 12:17:08 -0800
> Alexander Duyck <aduyck@mirantis.com> wrote:
>
>> >From what I can tell the practical limitation on the size of the Tx data
> extra >

Looks like this was already fixed in the patchwork as it doesn't seem
to have the same issue and I don't see the issue in Jeff's tree.

>> buffer is the fact that the Tx descriptor is limited to 14 bits.  As such
>> we cannot use 16K as is typically used on the other Intel drivers.  However
>> artificially limiting ourselves to 8K can be expensive as this means that
>> we will consume up to 10 descriptors (1 context, 1 for header, and 9 for
>> payload, non-8K aligned) in a single send.
>
> ...
>
>
>> +static inline unsigned int i40e_txd_use_count(unsigned int size)
>> +{
>> +     const unsigned int max = I40E_MAX_DATA_PER_TXD_ALIGNED;
>> +     const unsigned int reciprocal = ((1ull << 32) - 1 + (max / 2)) / max;
>> +     unsigned int adjust = ~(u32)0;
>> +
>> +     /* if we rounded up on the reciprprocal pull down the adjustment */
>
> spelling of reciprocal...

...

>> +static inline unsigned int i40e_txd_use_count(unsigned int size)
>> +{
>> +     const unsigned int max = I40E_MAX_DATA_PER_TXD_ALIGNED;
>> +     const unsigned int reciprocal = ((1ull << 32) - 1 + (max / 2)) / max;
>> +     unsigned int adjust = ~(u32)0;
>> +
>> +     /* if we rounded up on the reciprprocal pull down the adjustment */
>
> Spelling of reciprocal

I can submit a v3 for these two typos if needed, or if Jeff could fix
them in the tree that would be even better.  Just let me know which
you would prefer and I can submit an updated patch if needed.

- Alex
