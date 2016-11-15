From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Tue, 15 Nov 2016 10:59:28 +0100
Subject: [Intel-wired-lan] Out-of-order HW TX timestamps
Message-ID: <20161115095928.GA13694@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm trying to understand a problem with HW timestamping that was
reported for an i350 NIC and kernel 4.4.26. I'm not sure if this is
actually a kernel/driver/HW bug or rather the application (an NTP
implementation) has unreasonable expections.

The problem seems to be that the NTP client occasionally receives a
response from the server before the HW TX timestamp of the request is
available in the error queue and the offset is calculated from an
inaccurate TX timestamp. The server is a HW NTP appliance which
responds very quickly (just few microseconds).

Are messages with TX timestamps from the error queue expected to lag
behind actual messages? The same socket is used for sending and
receiving. The messages are processed asynchronously. As a test, I
suggested to add a usleep(100) call after sendmsg() to give the
message with TX timestamp more time to get in the error queue, but it
didn't help.

I didn't see this problem in my testing with i210, 82579LM and some
non-Intel cards, but the NTP servers I have are much slower. I can ask
the user to try a newer kernel if you think this this is not how it's
supposed to work and there were some related changes recently. In a
quick search through git log I didn't notice anything.

-- 
Miroslav Lichvar
