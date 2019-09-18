From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 18 Sep 2019 13:29:58 -0700
Subject: [Intel-wired-lan] [PATCH v1] igc: Add set_rx_mode support
In-Reply-To: <d0ecf9ed-f12f-f204-5223-6f845150a56d@redhat.com>
References: <20190910070512.31391-1-sasha.neftin@intel.com>
 <d0ecf9ed-f12f-f204-5223-6f845150a56d@redhat.com>
Message-ID: <CAKgT0Ue2rti-T1F9N02ejv2qgQuu7pM6aFCh7QJSys-B2MiNBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 18, 2019 at 12:29 PM David Arcari <darcari@redhat.com> wrote:
>
> Hi,
>
> On 09/10/2019 03:05 AM, Sasha Neftin wrote:
> > Add multicast addresses list to the MTA table.
> > Implement promiscious mode and add basic rx mode support.
> > Add option for ipv6 address settings.
> >
> > Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>
> This seems to break ipv4 communication over vlans:

Why is this code messing with the VLANs? The patch description says it
is enabling multicast and the MTA but it is messing with the VFTA
table as well. That is probably what broke the VLANs.

I don't see the bits to support ndo_vlan_rx_[add|kill]_vid and without
that it will break VLANs since the driver is filtering them unless
promiscuous filtering is enabled. The VLAN changes should be moved
into a separate patch.
