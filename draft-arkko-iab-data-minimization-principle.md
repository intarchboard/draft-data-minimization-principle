---
title: "Emphasizing Data minimization among protocol participants"
abbrev: Data Minimization
docname: draft-arkko-iab-data-minimization-principle
date: March 2023
category: info

ipr: trust200902
keyword: Internet-Draft

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
  -
    ins: J. Arkko
    name: Jari Arkko
    org: Ericsson
    street: Valitie 1B
    city: Kauniainen
    country: Finland
    email: jari.arkko@piuha.net

normative:

informative:
  RFC3552: 
  RFC6973: 
  RFC7258:
  RFC7816:
  RFC7819:
  RFC7824:
  RFC7844: 
  RFC7858:
  RFC8546:
  RFC8484:
  RFC8558:
  RFC8980:
  RFC9000: 
  RFC9076:
  I-D.farrell-etm:
  I-D.arkko-arch-internet-threat-model-guidance:
  I-D.lazanski-smart-users-internet:
  I-D.iab-path-signals-collaboration:
  I-D.iab-privacy-partitioning:
  I-D.thomson-tmi:
  I-D.iab-use-it-or-lose-it:
  I-D.wood-pearg-website-fingerprinting:
  I-D.ietf-ohai-ohttp:
  I-D.pauly-dprive-oblivious-doh:
  I-D.ietf-ppm-dap:
  I-D.annee-dprive-oblivious-dns:
  Confidentiality:
   title: "IAB Statement on Internet Confidentiality"
   date: November 2014
   author:
     - ins: The Internet Architecture Board
   seriesinfo: "https://www.iab.org/2014/11/14/iab-statement-on-internet-confidentiality/"
  PoLP:
   title: "The Protection of Information in Computer Systems"
   date: October 1975
   author:
     - ins: J. Saltzer
     - ins: M. Schroader
   seriesinfo: "Fourth ACM Symposium on Operating System Principles"
  WP2021:
   title: "There’s no escape from Facebook, even if you don’t use it"
   date: August 2021
   author:
     - ins: Geoffrey A. Fowler
   seriesinfo: "Washington Post"
  Fingerprinting:
    title: "Browser Fingerprinting: A survey"
    date: November 2019
    author:
     - ins: P. Laperdrix
     - ins: N. Bielova
     - ins: B. Baudry
     - ins: G. Avoine
    seriesinfo: "arXiv:1905.01051v2 [cs.CR] 4 Nov 2019"
  AmIUnique:
    title: "Am I Unique?"
    date: 2020
    author:
    - ins: INRIA
    seriesinfo: "https://amiunique.org"
  
--- abstract

Data minimization is an important privacy technique, as it can reduce
the amount information exposed about a user.  This document emphasizes
the need for data minimization among primary protocol participants,
such as between clients and servers. Avoiding data leakage to outside
parties is of course very important as well, but both need to be considered
in minimization.

This is because is necessary to protect against endpoints that are
compromised, malicious, or whose interests simply do not align with
the interests of users. It is important to consider the role of a
participant and limit any data provided to it according to that
role.

--- middle

# Introduction {#introduction}

Privacy been at the center of many activities in the IETF.  Privacy
and its impact on protocol development activities at IETF is discussed
in {{RFC6973}}, covering a number of topics, from understanding
privacy threats to threat mitigation, including data minimization.

This document emphasizes the need for data minimization among primary
protocol participants, such as between clients and servers. Avoiding
data leakage to outside parties such as observers or attackers is of
course very important as well, but minimization needs to consider
both.

As RFC 6973 states:

       "Limiting the data collected by protocol elements to
        only what is necessary (collection limitation) is 
        the most straightforward way to help reduce privacy
        risks associated with the use of the protocol."

This document offers some further discussion, motivation, and
clarification for this. This document suggests that limiting the
sharing of data to the protocol participants is a key technique in
limiting the data collection mentioned above. It is important that
minimization happens prior to disclosing information to another
party, rather than relying on the good will of the other party to 
avoid storing the information.

This is because is necessary to protect against endpoints that are
compromised, malicious, or whose interests simply do not align with
the interests of users. It is important to consider the role of a
participant and limit any data provided to it according to that role.

Even closed, managed networks may have compromised nodes, justifying
careful consideration of what information is provided to different
nodes in the network.  And in all networks, increased use of
communication security means adversaries may resort to new avenues of
attack. New adversaries and risks have also arisen, e.g., due to
increasing amount of information stored in various Internet
services. And in situations where interests do not align across the
protocol participants, limiting data collection by a protocol
participant itself - who is interested in data collection - may not be
sufficient.

Careful control of information is also useful for technology
evolution. For instance, allowing a party to unnecessarily collect or
receive information may lead to a similar effect as described in
{{RFC8546}} for protocols: regardless of initial expectations, over
time unnecessary information will get used, leading to, for instance,
ossification. Systems end up depend on having access to exactly the
same information as they had access to previously. This makes it hard
to change what information is provided or how it is provided.

# Recommendations {#rec}

The Principle of Least Privilege {{PoLP}} is applicable:

      "Every program and every user of the system should operate 
       using the least set of privileges necessary to complete the
       job."

In this context, it is recommended that the protocol participants
minimize the information they share. I.e., they should provide only
the information to each other that is necessary for the function that
is expected to be performed by the other party.

# Discussion

## Types of Protocol Exchanges

Information sharing may relate to different types of protocol
exchanges, e.g., interaction of an endpoint with outsiders, the network, or 
intermediaries.

Other documents address aspects related to networks
({{RFC8546}}, {{RFC8558}}, {{I-D.iab-path-signals-collaboration}}). Thomson {{I-D.thomson-tmi}}
discusses the role intermediaries. Communications security largely
addresses observers and outsider adversaries, see for instance {{Confidentiality}},
{{RFC7858}}, {{RFC8446}}, {{RFC8484}}, {{RFC9000}}. And {{RFC6973}}
discusses associated traffic analysis threats. The focus in this
document is on the primary protocol participants, such as a server in
a client-server architecture or a service enables some kind of
interaction among groups of users.

As with communication security, we try to avoid providing too much
information as it may be misused or leak through attacks. The same
principle applies not just to routers and potential attackers on path,
but also many other services in the Internet, including servers that
provide some function.

## Types of information

The use of identifiers has been extensively discussed in {{RFC6973}},

Note that indirectly inferred information can also end up being
shared, such as message arrival times or patterns in the traffic flow
({{RFC6973}}). Information may also be obtained from fingerprinting
the protocol participants, in an effort to identify unique endpoints
or users. Information may also be combined from multiple sources,
e.g., websites and social media systems collaborating to identify
visiting users {{WP2021}}.

## Different Ways of Avoiding Information Sharing

The most straightforward approach is of course to avoid sending a
particular piece of information at all.

Or the information needs to be encrypted to very specific recipients,
even if the encrypted message is shared with a broader set of protocol
participants. For instance, a
client can encrypt a message only to the actual final recipient, even
if the server holds the message before it is delivered. 

    Architectural note: A transport connection between
	two components of a system is not an end-to-end 
	connection even if it encompasses all the protocol
	layers up to the application layer. It is not 
	end-to-end, if the information or control function
	it carries extends beyond those components. Just
	because an e-mail server can read the contents of
	an e-mail message do not make it a legitimate
    recipient of the e-mail.

This document recommends that information should not be disclosed,
stored, or routed in cleartext through services that do not need to
have that information for the function they perform.

Where the above methods are not possihle due to the information being necessary for
a function that the user wishes to be performed, there are still
methods to set limits on the information sharing. 

Kühlewind et al discuss the concept of Privacy Partititioning
{{I-D.iab-privacy-partitioning}}. This may involve designs where no
single party has all information such as with Oblivious DNS
{{I-D.annee-dprive-oblivious-dns}}, {{I-D.pauly-dprive-oblivious-doh}}
or HTTP {{I-D.ietf-ohai-ohttp}}, cryptographic designs where a service
such as with the recent IETF PPM effort {{I-D.ietf-ppm-dap}}, and so
on.

## Role of Trust

Of course, participants may provide more information to each other
after careful consideration, e.g., information provided in exchange of
some benefit, or to parties that are trusted by the participant.

## Evolvability and Fingerprinting

The general topic of ensuring that protocol mechanisms stays evolvable
and workable is covered in {{I-D.iab-use-it-or-lose-it}}. But the
associated methods for reducing fingerprinting possibilities probably
deserve further study {{Fingerprinting}}
{{AmIUnique}}. {{I-D.wood-pearg-website-fingerprinting}} discusses one
aspect of this.

## Related work {#related}

Cooper et al.  {{RFC6973}} discuss the general concept of privacy,
including data minimization. Among other things, it provides the
general statement quoted in {{introduction}}. It also provides
guidelines to authors of specifications, a number of questions that
protocol designers can use to further analyse the impact of their
design.  For data minimization the questions relate to identifiers,
data, observers, and fingerprinting. This includes, for instance,
asking what information is exposed to which protocol entities, and if
there are ways to limit such exposure:

        Observers.  Which information discussed in (a) and (b)
        is exposed to each other protocol entity (i.e., recipients,
        intermediaries, and enablers)?  Are there ways for protocol
        implementers to choose to limit the information shared with
        each entity?  Are there operational controls available to
        limit the information shared with each entity?

This is is very much in line with this document, although it would be desirable
to have recommendation as well as questions, e.g., recommending
against sharing information with a participant if it is not necessary
for the expected role of that participant. And, as discussed earlier,
it is important to distinguish between the choices of a sender not
sharing information and a receiver choosing to not collect
information. Trusting an entity to not collect is not sufficient.

There has also been a number of documents that address data
minimization for specific situations, such as one DNS Query Name
Minimization {{RFC7816}}, general DNS privacy advice including data
minimization {{RFC9076}}, advice for DHCP clients for minimizing
information in requests they send to DHCP servers {{RFC7844}} (along
with general privacy considerations of DHCP {{RFC7819}}
{{RFC7824}}). These are on the topic of limiting information sent by
one primary protocol particiant (client) to another (server).

Hardie {{RFC8558}} and Arkko et
al. {{I-D.iab-path-signals-collaboration}} discuss path signals, i.e.,
messages to or from on-path elements to endpoints. In the past, path
signals were often implicit, e.g., network nodes interpreting in a
particular way transport protocol headers originally intended for
end-to-end consumption.  Implicit signals should be avoided and that
explicit signals be used instead.

Kuehlewind, Pauly, and Wood {{I-D.iab-privacy-partitioning}} discuss
the concept of privacy partitioning: how information can be split and
carefully shared in ways where no individual party beyond the client
requesting a service has full picture of who is asking and what is
being asked.

Thomson {{I-D.thomson-tmi}} discusses the role intermediaries in the
Internet architecture, at different layers of the stack. For instance,
a router is an intermediary, some parts of DNS infrastructure can be
intermediaries, messaging gateways are intermediaries. Thomson
discusses when intermediaries are or are not an appropriate tool, and
presents a number of principles relating to the use of intermediaries.

Trammel and Kühlewind {{RFC8546}} discuss the concept of a "wire
image" of a protocol, and how network elements may start to rely
on information in the image, even if it was not originally intended
for them. The issues are largely the same even for
participants.

# Acknowledgements {#ack}

The author would like to thank the participants of various IAB
workshops and programs, and IETF discussion list contributors for
interesting discussions in this area.  The author would in particular
like to acknowledge the significant contributions of Martin Thomson,
Nick Doty, Alissa Cooper, Stephen Farrell, Mark McFadden, John
Mattsson, Chris Wood, Dominique Lazanski, Eric Rescorla, Russ Housley,
Robin Wilton, Mirja Kuehlewind, Tommy Pauly, Jaime Jiménez and
Christian Huitema.

This work has been influenced by {{RFC6973}}, {{RFC8980}},
{{I-D.farrell-etm}} {{I-D.arkko-arch-internet-threat-model-guidance}},
{{I-D.lazanski-smart-users-internet}},
