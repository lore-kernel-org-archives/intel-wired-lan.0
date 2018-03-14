From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 15:16:33 -0700
Subject: [Intel-wired-lan] [PATCH 02/15] ice: Add support for control
 queues
In-Reply-To: <af3a595f-a9ab-8706-3d94-151a92d5d63a@oracle.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-3-anirudh.venkataramanan@intel.com>
 <af3a595f-a9ab-8706-3d94-151a92d5d63a@oracle.com>
Message-ID: <1521065793.19147.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-03-12 at 19:05 -0700, Shannon Nelson wrote:
> On 3/9/2018 9:21 AM, Anirudh Venkataramanan wrote:
> > A control queue is a hardware interface which is used by the driver
> > to interact with other subsystems (like firmware, PHY, etc.). It is
> > implemented as a producer-consumer ring. More specifically, an
> > "admin queue" is a type of control queue used to interact with the
> > firmware.
> > 
> > This patch introduces data structures and functions to initialize
> > and teardown control/admin queues. Once the admin queue is
> > initialized,
> > the driver uses it to get the firmware version.
> > 
> > Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel
> > .com>
> > ---
> >    drivers/net/ethernet/intel/ice/Makefile         |   4 +-
> >    drivers/net/ethernet/intel/ice/ice.h            |   1 +
> >    drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 108 +++
> >    drivers/net/ethernet/intel/ice/ice_common.c     | 144 ++++
> >    drivers/net/ethernet/intel/ice/ice_common.h     |  39 +
> >    drivers/net/ethernet/intel/ice/ice_controlq.c   | 979
> > ++++++++++++++++++++++++
> >    drivers/net/ethernet/intel/ice/ice_controlq.h   |  97 +++
> >    drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  46 ++
> >    drivers/net/ethernet/intel/ice/ice_main.c       |  11 +-
> >    drivers/net/ethernet/intel/ice/ice_osdep.h      |  86 +++
> >    drivers/net/ethernet/intel/ice/ice_status.h     |  35 +
> >    drivers/net/ethernet/intel/ice/ice_type.h       |  22 +
> >    12 files changed, 1570 insertions(+), 2 deletions(-)
> >    create mode 100644
> > drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> >    create mode 100644 drivers/net/ethernet/intel/ice/ice_common.c
> >    create mode 100644 drivers/net/ethernet/intel/ice/ice_common.h
> >    create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.c
> >    create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.h
> >    create mode 100644
> > drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> >    create mode 100644 drivers/net/ethernet/intel/ice/ice_osdep.h
> >    create mode 100644 drivers/net/ethernet/intel/ice/ice_status.h
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/Makefile
> > b/drivers/net/ethernet/intel/ice/Makefile
> > index 2a177ea21b74..eebf619e84a8 100644
> > --- a/drivers/net/ethernet/intel/ice/Makefile
> > +++ b/drivers/net/ethernet/intel/ice/Makefile
> > @@ -24,4 +24,6 @@
> >    
> >    obj-$(CONFIG_ICE) += ice.o
> >    
> > -ice-y := ice_main.o
> > +ice-y := ice_main.o  \
> > +      ice_controlq.o \
> > +      ice_common.o
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h
> > b/drivers/net/ethernet/intel/ice/ice.h
> > index d781027330cc..ea2fb63bb095 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -26,6 +26,7 @@
> >    #include <linux/compiler.h>
> >    #include <linux/pci.h>
> >    #include <linux/aer.h>
> > +#include <linux/delay.h>
> >    #include <linux/bitmap.h>
> >    #include "ice_devids.h"
> >    #include "ice_type.h"
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> > b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> > new file mode 100644
> > index 000000000000..885fa3c6fec4
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> > @@ -0,0 +1,108 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Intel(R) Ethernet Connection E800 Series Linux Driver
> > + * Copyright (c) 2018, Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify it
> > + * under the terms and conditions of the GNU General Public
> > License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> > WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for
> > + * more details.
> > + *
> > + * The full GNU General Public License is included in this
> > distribution in
> > + * the file called "COPYING".
> > + */
> > +
> > +#ifndef _ICE_ADMINQ_CMD_H_
> > +#define _ICE_ADMINQ_CMD_H_
> > +
> > +/* This header file defines the Admin Queue commands, error codes
> > and
> > + * descriptor format.  It is shared between Firmware and Software.
> > + */
> > +
> > +struct ice_aqc_generic {
> > +     __le32 param0;
> > +     __le32 param1;
> > +     __le32 addr_high;
> > +     __le32 addr_low;
> > +};
> > +
> > +/* Get version (direct 0x0001) */
> > +struct ice_aqc_get_ver {
> > +     __le32 rom_ver;
> > +     __le32 fw_build;
> > +     u8 fw_branch;
> > +     u8 fw_major;
> > +     u8 fw_minor;
> > +     u8 fw_patch;
> > +     u8 api_branch;
> > +     u8 api_major;
> > +     u8 api_minor;
> > +     u8 api_patch;
> > +};
> > +
> > +/* Queue Shutdown (direct 0x0003) */
> > +struct ice_aqc_q_shutdown {
> > +#define ICE_AQC_DRIVER_UNLOADING     BIT(0)
> > +     __le32 driver_unloading;
> > +     u8 reserved[12];
> > +};
> > +
> > +/**
> > + * struct ice_aq_desc - Admin Queue (AQ) descriptor
> > + * @flags: ICE_AQ_FLAG_* flags
> > + * @opcode: AQ command opcode
> > + * @datalen: length in bytes of indirect/external data buffer
> > + * @retval: return value from firmware
> > + * @cookie_h: opaque data high-half
> > + * @cookie_l: opaque data low-half
> > + * @params: command-specific parameters
> > + *
> > + * Descriptor format for commands the driver posts on the Admin
> > Transmit Queue
> > + * (ATQ).  The firmware writes back onto the command descriptor
> > and returns
> > + * the result of the command.  Asynchronous events that are not an
> > immediate
> > + * result of the command are written to the Admin Receive Queue
> > (ARQ) using
> > + * the same descriptor format.  Descriptors are in little-endian
> > notation with
> > + * 32-bit words.
> > + */
> > +struct ice_aq_desc {
> > +     __le16 flags;
> > +     __le16 opcode;
> > +     __le16 datalen;
> > +     __le16 retval;
> > +     __le32 cookie_high;
> > +     __le32 cookie_low;
> > +     union {
> > +             u8 raw[16];
> > +             struct ice_aqc_generic generic;
> > +             struct ice_aqc_get_ver get_ver;
> > +             struct ice_aqc_q_shutdown q_shutdown;
> > +     } params;
> > +};
> 
> You might put a compile-time size check on this struct - it helped
> many 
> times in i40e development.

We have taken appropriate actions to prevent the issues had with i40e
so that the ice driver should not need the same checks that i40e
required.  Also there are Linux kernel macros that are more appropriate
 for build-time checks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180314/ee94f0b0/attachment.asc>
