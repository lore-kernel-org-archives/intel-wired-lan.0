From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Mon, 11 May 2020 13:41:43 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] Virtual bus usage in the audio driver
Message-ID: <20200511204146.19176-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series shows an example of how the Virtual bus implementation
is used in the Sound Open Firmware (SOF) audio driver. 

A client in the SOF context is a device that needs to communicate
with the DSP via IPC messages. The SOF core is responsible for
serializing the IPC messages to the DSP from the different clients.
One example of an SOF client would be an IPC test client that
floods the DSP with test IPC messages to validate if the
serialization works as expected. Multi-client support will also add
the ability to split the existing audio cards into multiple ones,
so as to e.g. to deal with HDMI with a dedicated client instead of
adding HDMI to all cards.

Ranjani Sridharan (3):
  ASoC: SOF: Introduce descriptors for SOF client
  ASoC: SOF: Create client driver for IPC test
  ASoC: SOF: ops: Add new op for client registration

 sound/soc/sof/Kconfig               |  30 +++
 sound/soc/sof/Makefile              |   6 +-
 sound/soc/sof/core.c                |  10 +
 sound/soc/sof/intel/Kconfig         |   1 +
 sound/soc/sof/intel/apl.c           |  25 +++
 sound/soc/sof/intel/bdw.c           |  25 +++
 sound/soc/sof/intel/byt.c           |  28 +++
 sound/soc/sof/intel/cnl.c           |  25 +++
 sound/soc/sof/ops.h                 |  34 +++
 sound/soc/sof/sof-client.c          |  91 ++++++++
 sound/soc/sof/sof-client.h          |  84 +++++++
 sound/soc/sof/sof-ipc-test-client.c | 325 ++++++++++++++++++++++++++++
 sound/soc/sof/sof-priv.h            |   9 +
 13 files changed, 692 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/sof/sof-client.c
 create mode 100644 sound/soc/sof/sof-client.h
 create mode 100644 sound/soc/sof/sof-ipc-test-client.c

-- 
2.17.1

