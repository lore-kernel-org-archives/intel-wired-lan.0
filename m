From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 6 Jan 2017 08:15:27 -0800
Subject: [Intel-wired-lan] [next PATCH 0/9] igb: Add support for writable
	pages and build_skb
Message-ID: <CAKgT0UcRmn-utuTJemjQysox0ZJUNLAQGWAH8MDegJjPbSH57w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 6, 2017 at 8:10 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> This patch set enables support for using the recent changes that allow for
> unmapping pages without invalidating their contents via
> DMA_ATTR_SKIP_CPU_SYNC.  With this change DMA pages should be writable and
> as a result we should be able to make use of build_skb which can be used to
> drop the skb->head memory allocation, header parsing, and memcpy from the
> receive path which can greatly help to improve performance.
>
> My main concern at this point is that there might be an architecture where
> I didn't get DMA_ATTR_SKIP_CPU_SYNC implemented that might still need it.
> For that reason I have also added a ethtool private flag called out as
> "legacy-rx".  If a platform encounters an issue where the Rx can possibly
> corrupt data it can be enbled by running:
>         ethtool --set-priv-flags DEVNAME legacy-rx on
>
> The testing matrix for all of these patches is going to be pretty
> extensive.  Basically we want to test these patches on as many platforms
> and architectures as possible with as many features being toggled as
> possible including SR-IOV and Jumbo Frames all while receiving traffic.
>
> Within the patches there is also some initialization changes.  Specifically
> I have updated the code paths to defer clearing the rings until we are
> about to initialize them and give them to hardware.  By doing this we are
> able to avoid having to dirty memory we don't need to which should help to
> improve suspend/resume times for when we start looking at possibly using
> the suspend/resume approach for migration of interface in VMs.

In my hurry to just copy/paste the ixgbe patch description over and
make a few changes it looks like I left a few typos, my appologies.
This should have been 0/9, not 00/11.
