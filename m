From: Piatkowski, Robert <robert.piatkowski@intel.com>
Date: Wed, 17 Jan 2018 12:45:58 +0000
Subject: [Intel-wired-lan] Patch for iproute2
Message-ID: <34C81C09865FAD44ABA68FB83DDA0E4D9CC5B73B@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,
I want to submit a patch for iproute2 - taken from https://github.com/eworm-de/iproute2 - we use this version as it contains pretty recent XFRM offload configuration capability.

During development, we found a stack buffer overflow bug that causes mass deletion of states command to fail under some circumstances. So we developed a fix for that (see attachment).

The fix was reviewed by Don Skidmore, and he suggested to forward it to you. I tried to make the description sound similar to other commits' description in the repository.

Is the fix OK in the current state? What are the next steps for me?

Robert
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180117/d4e185a2/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fix-stack-buffer-overflow-when-removing-many-states.patch
Type: application/octet-stream
Size: 1404 bytes
Desc: 0001-fix-stack-buffer-overflow-when-removing-many-states.patch
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180117/d4e185a2/attachment.obj>
