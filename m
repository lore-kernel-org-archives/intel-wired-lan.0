From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Aug 2019 20:48:00 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <901704f1-163d-9dd8-4d20-93fa19f4435d@oracle.com>
References: <20190807024917.27682-1-firo.yang@suse.com>
 <85aaefdf-d454-1823-5840-d9e2f71ffb19@oracle.com>
 <20190807083831.GA6811@linux-6qg8>
 <901704f1-163d-9dd8-4d20-93fa19f4435d@oracle.com>
Message-ID: <CAKgT0Uda0x8N7jv5Ex4x0tv85RgeHr5XQJCvDWCrD9VBu-4QPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Aug 7, 2019 at 6:58 PM Jacob Wen <jian.w.wen@oracle.com> wrote:
>
>
> On 8/7/19 4:38 PM, Firo Yang wrote:
> > The 08/07/2019 15:56, Jacob Wen wrote:
> >> I think the description is not correct. Consider using something like below.
> > Thank you for comments.
> >
> >> In Xen environment, due to memory fragmentation ixgbe may allocate a 'DMA'
> >> buffer with pages that are not physically contiguous.
> > Actually, I didn't look into the reason why ixgbe got a DMA buffer which
> > was mapped to Xen-swiotlb area.
> Yes. I was wrong. You don't need to tell the exact reason.
> >
> > But I don't think this issue relates to phsical memory contiguity because, in
> > our case, one ixgbe_rx_buffer only associates at most one page.
>
> This is interesting.
>
> I guess the performance of the NIC in your environment is not good due
> to the extra cost of bounce buffer.

If I recall correctly the Rx performance for ixgbe shouldn't be too
bad even with a bounce buffer. The cost for map/unmap are expensive
for a bounce buffer setup but the syncs are just copies so they are
pretty cheap in comparison. The driver can take advantage of that on
Rx since it leaves the pages mapped and just syncs the portion of the
pages that are used.

Now if you are hitting the bounce buffer on the Tx side that is
another matter as you have to allocate the buffer on demand and that
is quite expensive.
